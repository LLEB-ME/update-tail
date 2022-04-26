#!/bin/sh
arch=$(uname -m)
echo "arch: $OSArch"
if [[ arch == "arm64" ]]; then
  TSFILE=tailscale_1.24.0_arm64.tgz
elif [[ arch == "x86_64" ]]; then
  TSFILE=tailscale_1.24.0_amd64.tgz
else
  echo "unknown arch. quitting."
  exit 1;
fi
echo "downloading: $TSFILE"

# Check for sudoers and attempt upgrade
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  sudo $0;
  exit;
fi

# Update/Install Tailscale
wget https://pkgs.tailscale.com/stable/${TSFILE}
tar xzf ${TSFILE} --strip-components=1 -C .
cp tailscale /usr/bin/tailscale
cp tailscaled /usr/sbin/tailscaled
mkdir -p /var/run/tailscale
mkdir -p /var/cache/tailscale
mkdir -p /var/lib/tailscale

# Ensure IP forwarding is on
#echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.conf
#echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.conf
#echo 'net.ipv6.conf.all.disable_policy = 1' | tee -a /etc/sysctl.conf
#sysctl -p /etc/sysctl.conf

# Get service up again
/usr/bin/tailscale up
read -p "prompt: what init system? (openrc, runit)" x
if [[ x == "openrc" ]]; then
  rc-service tailscale restart
elif [[ x == "runit" ]]; then
  sv restart tailscale
else
  echo "invalid init."
  exit 1;
fi

# Remove downloaded files
rm -r tailscale tailscaled ${TSFILE} systemd/
exit 0;
