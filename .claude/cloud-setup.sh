#!/usr/bin/env bash
# The cloud environment's setup script (ADR 0008), taken from Varve's.
#
# Runs as root on a fresh VM before Claude Code launches, once per environment
# cache, never on a local machine. Install it by setting the environment's
# "Setup script" field at claude.ai/code to
#
#   curl -fsSL https://raw.githubusercontent.com/Hafeok/writ/main/.claude/cloud-setup.sh | bash
#
# and set CLAUDE_GIT_SIGNING_KEY in the same environment to the agent's
# private signing key, which .claude/hooks/cloud-git-identity.sh writes at
# session start. Exit non-zero and the session does not start; take longer
# than about five minutes and nothing is cached. Each step is guarded.
set -u
export DEBIAN_FRONTEND=noninteractive

echo "--- openssh-client: ssh-keygen, which git needs to sign with the agent key"
if ! command -v ssh-keygen >/dev/null 2>&1; then
    (apt-get update -qq && apt-get install -y -qq openssh-client) \
        || echo "openssh-client: install failed; commits in this environment stay unsigned" >&2
fi

echo "--- dotnet: the SDK global.json pins"
# Kept in step with global.json by hand; the repository may not be cloned yet.
sdk_version=10.0.401
dotnet_root=/usr/share/dotnet
if ! "$dotnet_root/dotnet" --list-sdks 2>/dev/null | grep -q "^$sdk_version "; then
    (curl -fsSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh \
        && bash /tmp/dotnet-install.sh --version "$sdk_version" --install-dir "$dotnet_root" \
        && ln -sf "$dotnet_root/dotnet" /usr/bin/dotnet) \
        || echo "dotnet: install of $sdk_version failed; the build cannot run" >&2
    rm -f /tmp/dotnet-install.sh
fi
cat > /etc/profile.d/dotnet.sh <<PROFILE
export DOTNET_ROOT=$dotnet_root
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
PROFILE

echo "--- what this VM now has"
command -v ssh-keygen >/dev/null 2>&1 && echo "ssh-keygen: $(command -v ssh-keygen)" || echo "ssh-keygen: missing"
command -v dotnet >/dev/null 2>&1 && dotnet --version || echo "dotnet: missing"
