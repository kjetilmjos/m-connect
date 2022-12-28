#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: WireGuard
# Creates the interface configuration
# ==============================================================================
declare config_dir
declare clientname
declare peer_private_key
declare peer_public_key
declare tunnelip
declare host
declare port

clientname="m-connect"
config_dir="/ssl/wireguard/${clientname}"

if ! bashio::fs.directory_exists '/ssl/wireguard'; then
    mkdir -p /ssl/wireguard ||
        bashio::exit.nok "Could not create wireguard storage folder!"
fi

if ! bashio::fs.directory_exists '/etc2'; then
    mkdir -p /etc2 ||
        bashio::exit.nok "Could not create wireguard config directory!"
fi
if ! bashio::fs.directory_exists '/etc/wireguard'; then
    mkdir -p /etc/wireguard ||
        bashio::exit.nok "Could not create wireguard config directory!"
fi
# Create directory for storing client configuration
mkdir -p "${config_dir}" ||
    bashio::exit.nok "Failed creating client folder for ${clientname}"

# Status API Storage
if ! bashio::fs.directory_exists '/var/lib/wireguard'; then
    mkdir -p /var/lib/wireguard \
        || bashio::exit.nok "Could not create status API storage folder"
fi

# If a public key is not provided, try get a private key from disk
# or generate one if needed.
if ! bashio::fs.file_exists "${config_dir}/private_key"; then
    umask 077 || bashio::exit.nok "Could not set a proper umask"
    wg genkey > "${config_dir}/private_key" ||
        bashio::exit.nok "Could not generate private key for ${clientname}!"
fi
peer_private_key=$(<"${config_dir}/private_key")

# Get the public key
peer_public_key=""
if bashio::var.has_value "${peer_private_key}"; then
    peer_public_key=$(wg pubkey <<< "${peer_private_key}")
    echo "$peer_public_key" > "${config_dir}/public_key"
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
 {
echo "[Interface]"
echo "Address = ${tunnelip}"
echo "PrivateKey = ${peer_private_key}"
echo "DNS = 8.8.8.8"
echo ""
echo "[Peer]"
echo "PublicKey = ${peer_public_key}"
echo "AllowedIPs = 10.50.60.0/24"
echo "Endpoint = ${host}:${port}"
echo "PersistentKeepalive = 25"
 } > "${config_dir}/${clientname}.conf"

cp "${config_dir}/${clientname}.conf" "/etc/wireguard/${clientname}.conf"
# Store client name for the status API based on public key
filename=$(sha1sum <<< "${peer_public_key}" | awk '{ print $1 }')
echo -n "${clientname}" > "/var/lib/wireguard/${filename}"