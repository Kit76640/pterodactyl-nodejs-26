# pterodactyl-nodejs-26

Node.js 26 + git image for [Pterodactyl](https://pterodactyl.io), inspired by [pterodactyl/yolks](https://github.com/pterodactyl/yolks).

**Image:** `ghcr.io/kit76640/pterodactyl-nodejs-26:latest`

## Security / updates
- Based on `node:26-trixie-slim` (floating tag: newest Node 26 patch on Debian stable).
- `apt-get upgrade` is run at build time for OS security fixes.
- GitHub Actions rebuilds from scratch **every Monday** (`pull` + `no-cache`), so the `latest` tag is always fresh.
- Wings pulls the image when a server is (re)started/reinstalled, so a restart picks up the newest build.
- Runs as non-root user `container` with `tini` as PID 1.

## Setup
1. After the first workflow run, set the GHCR package visibility to **public** (Package settings) so Wings can pull it.
2. Import `eggs/egg-nodejs-26-git.json` in the panel (Admin > Nests > Import Egg).
