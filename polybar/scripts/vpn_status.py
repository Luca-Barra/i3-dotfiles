#!/usr/bin/env python3

import subprocess

def is_wireguard_vpn_active():
    # Check the active connections with nmcli
    nmcli_output = subprocess.getoutput("nmcli --terse --fields TYPE,STATE,DEVICE con show --active")

    # Split the output into lines
    lines = nmcli_output.strip().split('\n')

    # Loop through the lines to check for WireGuard VPN connections
    for line in lines:
        fields = line.split(':')
        connection_type = fields[0]
        connection_state = fields[1]
        device = fields[2]

        if connection_type == "wireguard" and connection_state == "activated":
            return True

    return False

if __name__ == "__main__":
    vpn_active = is_wireguard_vpn_active()
    
    if vpn_active:
        vpn_status = " VPN"
    else:
        vpn_status = "⚠ VPN"

    # Output the VPN status directly
    print(vpn_status)
