#!/command/with-contenv bashio

if ! bashio::fs.directory_exists '/tmp/wireguard'; then
    mkdir -p /tmp/wireguard ||
        bashio::exit.nok "Could not create wireguard storage folder!"
fi
