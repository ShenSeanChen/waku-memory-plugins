#!/bin/sh
# Build the ZIP that goes to OpenAI's plugin directory (ChatGPT and Codex).
#
# OpenAI's directory refuses a plugin with lifecycle hooks, so this package is
# plugins/waku without them: the Codex manifest from openai/plugin.json, the
# MCP server, and the skill written for harnesses that run no hooks. Users who
# install from this repository's marketplace keep the hooks.
set -eu
here=$(cd "$(dirname "$0")/.." && pwd)
src="$here/plugins/waku"
out="$here/dist/openai"
version=$(sed -n 's/^  "version": *"\([^"]*\)".*/\1/p' "$here/openai/plugin.json")
plugin_version=$(sed -n 's/^  "version": *"\([^"]*\)".*/\1/p' "$src/.claude-plugin/plugin.json")
if [ "$version" != "$plugin_version" ]; then
  echo "openai/plugin.json is $version but plugins/waku is $plugin_version" >&2
  exit 1
fi
rm -rf "$out" "$here/dist/waku-openai-$version.zip"
mkdir -p "$out/.codex-plugin" "$out/assets" "$out/skills/waku"
cp "$here/openai/plugin.json" "$out/.codex-plugin/plugin.json"
cp "$here/openai/mcp.json" "$out/.mcp.json"
cp "$src/.codex-plugin/assets/logo.png" "$out/assets/logo.png"
cp "$src/skills-without-hooks/waku/SKILL.md" "$out/skills/waku/SKILL.md"
cp "$src/LICENSE" "$out/LICENSE"
(cd "$out" && zip -qrX "../waku-openai-$version.zip" .)
echo "Built dist/waku-openai-$version.zip"
