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
    # Get channel name from client's cache (https://github.com/slackapi/hubot-slack/issues/328)
    channelName = robot.adapter.client.rtm.dataStore.getChannelGroupOrDMById(reach(context, 'response.envelope.room')).name

    # Unless the room is in the allowlist
    unless channelName in allowlist
      # We're done
      context.response.message.finish()
      done()
    else
      next(done)
