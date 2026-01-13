#!/bin/bash
#
# disable_ipv6.sh — Disable IPv6 on RHEL 8.7
# Must be run as root.
#

# Exit on error
set -e

echo "=== Disabling IPv6 on RHEL 8.7 ==="

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

# 1. Disable IPv6 via sysctl (runtime + persistent)
echo "Disabling IPv6 via sysctl..."
cat <<EOF >/etc/sysctl.d/99-disable-ipv6.conf
# Disable IPv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

# Apply sysctl settings immediately
sysctl -p /etc/sysctl.d/99-disable-ipv6.conf

# 2. Disable IPv6 in GRUB boot parameters
echo "Updating GRUB configuration..."

# Check if ipv6.disable is already present
if grep -q "ipv6.disable=1" /etc/default/grub; then
  echo "GRUB already contains ipv6.disable=1"
else
  sed -i 's/GRUB_CMDLINE_LINUX="/GRUB_CMDLINE_LINUX="ipv6.disable=1 /' /etc/default/grub
fi

# 3. Regenerate GRUB config
if [ -d /sys/firmware/efi ]; then
  grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
else
  grub2-mkconfig -o /boot/grub2/grub.cfg
fi

echo "GRUB updated successfully."

# 4. Notify user
echo "IPv6 has been disabled. A reboot is required to fully apply changes."
echo "Run 'sudo reboot' when ready."
