# Waku Memory — plugin marketplace

This repository is a pointer. It holds two files that tell a harness where
the Waku Memory plugin lives, the npm package
[`waku-memory`](https://www.npmjs.com/package/waku-memory):
`.claude-plugin/marketplace.json` for Claude Code and
`.agents/plugins/marketplace.json` for Codex.

## Install in Claude Code

```
/plugin install waku --marketplace ShenSeanChen/waku-memory-plugins
```

then `/mcp` and choose `waku` to sign in. On Claude Code before 2.1.275 the
install is two commands: `/plugin marketplace add
ShenSeanChen/waku-memory-plugins`, then `/plugin install waku@waku-memory`.
Claude Code asks for no hook-trust step. The first prompt of a session brings
the brief; each turn's reply is sent for extraction once you turn capture on
at https://www.waku.one/integrations.

## Install in Codex

```
codex plugin marketplace add ShenSeanChen/waku-memory-plugins
codex plugin add waku@waku-memory
```

Installing runs a browser sign-in against Waku's authorization server and
stores the credential where Codex keeps it. Codex then asks you to review and
trust the plugin's three hooks. Until you trust them, the session brief and the
capture do not run — open `/hooks` in Codex to do it.

## What it does

Waku Memory keeps what you tell your agents and what they learn, and brings it
back into later sessions. `memory.recall` returns what is known about a
project; `memory.remember` keeps something worth keeping. The plugin's hooks
open each session with a short brief and send each turn to be remembered.

## What it sends — read this before installing

What you type and what the agent replies is sent to Waku's servers and on to
Anthropic, which is what turns a session into memories. Tool output, the files
the agent reads and the commands it runs are not sent, except where the agent
quotes them in its own reply; its reasoning is never sent.

Each prompt you give your agent is also sent, whether or not capture is on, so
the memories that bear on it can be shown beside it. That prompt is used for
that one search and is not stored.

**This is an alpha, and its data can be lost.** Do not put anything here you
cannot afford to lose.

## Without the plugin

`npx waku-memory capture enable` does the same thing from the command line, on
Codex and on Claude Code alike, and can also import the history those harnesses
already keep. It needs Node 20 or newer.

<https://www.waku.one/>
