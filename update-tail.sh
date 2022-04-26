#!/bin/sh
TSFILE=tailscale_1.24.0_arm64.tgz

# Check for sudoers and attempt upgrade
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  sudo $0;
  exit;
fi

# Update Tailscale
apk update
wget https://pkgs.tailscale.com/stable/${TSFILE} && \                                                                            
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
rc-service tailscale restart

# Remove downloaded files
rm -r tailscale tailscaled ${TSFILE} systemd/
