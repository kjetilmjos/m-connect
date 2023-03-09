# Home Assistant Add-on: m-connect

Wireguard client for Home Assistant

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
2. Select **Repositories** from the top right menu.
3. Paste the github URL for the project. https://github.com/kjetilmjos/m-connect
4. Click on the "ADD" button.
5. The addon is now available in the bottom of the page and can be installed.

## Configuration

Add-on configuration:

```yaml
host: str
port: int
publickey: str
tunnelip: str
```

### Option: `host` (required)

The public facing IPv4 address of your wireguard server

Set it to wireguard server IP `xxx.xxx.xxx.xxx`

### Option: `port` (required)

The port you have configured on the wireguard server for wireguard traffic.

Set to wireguard server port `xxxxx`.

### Option: `publickey` (required)

The public key from the wireguard master `xXXxxXxXXXX`

### Option: `tunnelip` (required)

The IP and CIDR range of the wireguard client.
The default range for the wireguard setup in m-connect is: 10.170.204.0/27.
If this is youur first client on the network you could choose for example. `xxx.xxx.xxx.xxx/27`

### Option: `enable_backup` (required)
Defaults to false. When true a backup will be synched to m-cloud server on regular intervals.

### Option: `username` (optional)
The username obtained from the m-cloud server

### Option: `password` (optional)
The password obtained from the m-cloud server

# Usage instructions

After you have configured the addon and the server you need to edit configuration.yaml in home assistant to allow traffic coming in from the addon.
Add this to configuration.yaml and restart Home Assistant

```yaml
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 172.30.33.0/24
```
