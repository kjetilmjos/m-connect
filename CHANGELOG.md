## 2023.4.2

- Backup path and server ip update

## 2023.4.1

- Sshpass fix
- Sleep interval on wireguard status set to 365 days

## 2023.4.0

- The script will now check timestamp on latest backup file on server and not create a new backup if an older one exists on the server.

## 2023.3.7

- Display public key on startup

## 2023.3.6

- Fixed issue with persistent storage for ssh id

## 2023.3.5

- The addon will now update the HA configuration file with the correct http settings.

## 2023.3.4

- Added ssh login and synchronization of backup

## 2023.3.3

- Updated logic for creating backup
- Improved error handling for backup creation

## 2023.3.2

- Minor fix of backup functionality
- Better log output from wireguard status

## 2023.3.1

- Added functionality for backup creation. This will be done daily if not any manual full backup is created in the meantime. This version is for testing only

## 2023.3.0

- Added first backup functionality with init script and longrun script. Functionality only supports to be disabled at the moment

## 2023.2.0

- Initial release
