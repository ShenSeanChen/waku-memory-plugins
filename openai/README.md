# OpenAI plugin directory package

These files build the Waku Memory package for OpenAI's plugin directory, which
lists plugins in ChatGPT and Codex. OpenAI's directory refuses a plugin with
lifecycle hooks. This package is `plugins/waku` without its hooks, so a memory
reaches a ChatGPT conversation only when the model calls a tool.

- `plugin.json` becomes `.codex-plugin/plugin.json` in the ZIP. It holds the
  listing text, the four listing links, the eight review test cases and the
  release notes.
- `mcp.json` becomes `.mcp.json`. It names the one MCP server,
  `https://api.waku.one/mcp`. The server registers OAuth clients itself
  (Dynamic Client Registration), so the package holds no client ID or secret.
- The skill comes from `plugins/waku/skills-without-hooks/`, because the Claude
  Code skill tells the model that a brief has already arrived.

Run `scripts/build-openai-zip.sh` to write `dist/waku-openai-<version>.zip`.
The script refuses to build when `plugin.json` and `plugins/waku` carry
different versions. Raise both together.

## What the package does not carry

OpenAI's dashboard takes these, and the ZIP must not contain them:

- The reviewer's test account, its login URL and its sign-in steps, under
  Review details.
- The demo video URL goes into `plugin.json` at
  `extensions.com.openai.review.demo_recording_url` once the video exists.

## The reviewer's test account

OpenAI requires an account that signs in without MFA, emailed codes or magic
links. The test cases expect these five memories in it, saved before review:

| Kind | Scope | Body |
|---|---|---|
| preference | global | Prefers pnpm over npm for JavaScript projects. |
| preference | global | Uses tabs, not spaces, for indentation in every project. |
| decision | project:orbit | Orbit stores its data in Postgres. MongoDB was considered in March 2026 and rejected because the team needed joins. |
| procedure | project:orbit | Release Orbit only on Tuesdays, after the staging smoke test passes. |
| fact | project:orbit | The Orbit staging site is staging.orbit.example.com. |

The fifth positive test case forgets the indentation memory. Save it again
before each new review.
