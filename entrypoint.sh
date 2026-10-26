#!/bin/bash
cd /home/container || exit 1

# Make internal Docker IP available to processes
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

NODE_VERSION=$(node -v)
echo "Running Node ${NODE_VERSION} / git $(git --version | awk '{print $3}')"

# Replace Pterodactyl {{VAR}} placeholders with env values
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

echo ":/home/container$ ${PARSED}"
# shellcheck disable=SC2086
exec env ${PARSED}
