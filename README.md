A simple Shell script to update Tailscale on some Linux distros easily. This was deprecated in favour of [ansible-tail](https://github.com/LLEB-ME/ansible-tail)

**Note:** this doesn't come with OpenRC or systemd services; you will have to manually add these yourself. The tarball comes with systemd services.
  - Alpine— `apk add tailscale-openrc`
  - Void— included with `tailscale` package; use this for "bleeding" edge

