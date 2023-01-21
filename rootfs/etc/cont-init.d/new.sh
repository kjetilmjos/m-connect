#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: WireGuard
# Creates the interface configuration
# ==============================================================================
declare config_dir
declare clientname
declare peer_private_key
declare peer_public_key
declare publickey
declare tunnelip
declare host
declare port
declare post_down
declare post_up

clientname="m-connect"
config_dir="/data/m-connect"
#config_dir="/etc/wireguard/${clientname}"

if ! bashio::fs.directory_exists '/etc/wireguard'; then
    mkdir -p /etc/wireguard ||
        bashio::exit.nok "Could not create wireguard folder!"
fi

if ! bashio::fs.directory_exists "${config_dir}"; then
    mkdir -p ${config_dir} ||
        bashio::exit.nok "Could not create persistent storage folder for m-connect!"
fi

# Status API Storage
if ! bashio::fs.directory_exists '/var/lib/wireguard'; then
    mkdir -p /var/lib/wireguard \
        || bashio::exit.nok "Could not create status API storage folder"
fi

# If private key not exists create a new one.
if ! bashio::fs.file_exists "${config_dir}/private_key"; then
    umask 077 || bashio::exit.nok "Could not set a proper umask"
    wg genkey > "${config_dir}/private_key" ||
        bashio::exit.nok "Could not generate private key for ${clientname}!"
fi
peer_private_key=$(<"${config_dir}/private_key")

# Get the public key if not exists
if ! bashio::fs.file_exists "${config_dir}/public_key"; then
    peer_public_key=""
    bashio::var.has_value "${peer_private_key}";
    peer_public_key=$(wg pubkey <<< "${peer_private_key}")
    echo "$peer_public_key" > "${config_dir}/public_key"
fi
# Get config input from addon UI
if bashio::config.has_value "server.publickey"; then
    publickey=$(bashio::config "server.publickey")
fi
if bashio::config.has_value "server.tunnelip"; then
    tunnelip=$(bashio::config "server.tunnelip")
fi

if bashio::config.has_value "server.host"; then
    host=$(bashio::config "server.host")
fi
if bashio::config.has_value "server.port"; then
    port=$(bashio::config "server.port")
fi
# Post Up & Down defaults
#post_up="iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE"
#post_down="iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE"

#post_up_ha='iptables -t nat -A PREROUTING -j DNAT --to-destination 172.30.32.1; iptables -t nat -A POSTROUTING -j MASQUERADE'
#post_down_ha='iptables -t nat -D PREROUTING -j DNAT --to-destination 172.30.32.1; iptables -t nat -D POSTROUTING -j MASQUERADE'

post_up="iptables -t nat -A PREROUTING -j DNAT --to-destination 172.30.32.1; iptables -t nat -A POSTROUTING -j MASQUERADE"
post_down="iptables -t nat -D PREROUTING -j DNAT --to-destination 172.30.32.1; iptables -t nat -D POSTROUTING -j MASQUERADE"


# IP forwarding warning
if [[ $(</proc/sys/net/ipv4/ip_forward) -eq 0 ]]; then
    bashio::log.warning
    bashio::log.warning "IP forwarding is disabled on the host system!"
    bashio::log.warning "You can still use WireGuard to access Hass.io,"
    bashio::log.warning "however, you cannot access your home network or"
    bashio::log.warning "the internet via the VPN tunnel."
    bashio::log.warning
    bashio::log.warning "Please consult the add-on documentation on how"
    bashio::log.warning "to resolve this."
    bashio::log.warning

    # Set fake placeholders for Up & Down commands
    post_up=""
    post_down=""
fi
# Write full config file
 {
echo "PostUp = ${post_up}"
echo "PostDown = ${post_down}"
echo "[Interface]"
echo "Address = ${tunnelip}"
echo "PrivateKey = ${peer_private_key}"
echo "DNS = 8.8.8.8"
echo "[Peer]"
echo "PublicKey = ${publickey}"
echo "AllowedIPs = 10.50.60.0/24"
echo "Endpoint = ${host}:${port}"
echo "PersistentKeepalive = 25"
echo ""

 } > "${config_dir}/${clientname}.conf"
# Store client name for the status API based on public key
#filename=$(sha1sum <<< "${peer_public_key}" | awk '{ print $1 }')

# Move config file to /etc/wireguard if the file does not exist
if ! bashio::fs.file_exists '/etc/wireguard/m-connect.conf'; then
    cp "${config_dir}/${clientname}.conf" "/etc/wireguard/${clientname}.conf" ||
        bashio::exit.nok "Unable to move config file to /etc/wireguard"
fi

echo -n "${clientname}" > "/var/lib/wireguard/m-connect"
