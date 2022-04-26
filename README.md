A simple Shell script to update Tailscale on some Linux distros easily.

**Note:** this doesn't come with OpenRC or systemd services; you will have to manually add these yourself. The tarball comes with systemd services, and you can grap the OpenRC service straight from the APK repositories (`edge/community`). 
  - Alpine— `apk add tailscale-openrc`
  - Void— included with `tailscale` package; use this for "bleeding" edge

