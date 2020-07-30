## Hubot Slack Allowlist

Don't want `#general` to trigger your bot?

**Use this.**

Originally based on https://github.com/michaeljacobdavis/hubot-slack-whitelist-middleware

## How to use

**Install**
```
npm install --save hubot-slack-allowlist-middleware
```

**Register**

In `external-scripts.json` add

```
"hubot-slack-allowlist-middleware"
```


This is meant for Slack, but might work with any [adapter](https://github.com/github/hubot/blob/master/docs/adapters.md) that exposes the current channel via `context.response.envelope.room`.

## Environment Variables
There are two ways to set a allowlist:

Environment Variable | Description | Example
--- | --- | ---
`HUBOT_ALLOWLIST` | A comma separated list (no spaces). | `random,general`
`HUBOT_ALLOWLIST_PATH` | Set the path (relative to your hubot directory) to a `json`/`js`/`coffee` file that returns an array of allowlisted channels. | `allowlist.json`
