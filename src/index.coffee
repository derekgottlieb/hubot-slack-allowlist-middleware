# Configuration:
#   HUBOT_ALLOWLIST
#   HUBOT_ALLOWLIST_PATH

reach = require('@hapi/hoek').reach
path = require('path')

module.exports = (robot) ->

  # Establish allowlist
  allowlist = []
  if process.env.HUBOT_ALLOWLIST
    allowlist = process.env.HUBOT_ALLOWLIST.split(',')
  else if process.env.HUBOT_ALLOWLIST_PATH
    allowlist = require(path.resolve(process.env.HUBOT_ALLOWLIST_PATH))

  unless Array.isArray(allowlist)
    robot.logger.error 'allowlist is not an array!'

  robot.receiveMiddleware (context, next, done) ->
    # Get channel name from client's cache.
    # See https://github.com/slackapi/hubot-slack/issues/328.
    #
    # Slack presence messages make this messy since they won't have a
    # channel name associated with them.
    channelId = reach(context, 'response.envelope.room')
    channelGroup = robot.adapter.client.rtm.dataStore.getChannelGroupOrDMById(channelId)
    if typeof channelGroup isnt 'undefined'
      channelName = channelGroup.name

    # Unless the room is in the allowlist
    unless channelName in allowlist
      # Channel not in allowlist, bail out
      context.response.message.finish()
      done()
    else
      # Channel in allowlist
      next(done)
