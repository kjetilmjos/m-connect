## 2023.7.3
- Fixed issue with extra fi statement

## 2023.7.2
- Fixed issue with empty file when starting first time bug4

## 2023.7.1
- Fixed issue with empty file when starting first time bug3

## 2023.7.0
- Fixed issue with empty file when starting first time bug

## 2023.6.9
- Fixed issue with empty file when starting first time

## 2023.6.8

- Created know hosts file using touch
## 2023.6.7

- Fixed bug on known host file checker
## 2023.6.6

- Improved known hosts file creation logic
## 2023.6.5

- Improved known hosts command.
## 2023.6.4

- Removed password from config file as this is not needed anymore due to key login instead
## 2023.6.3

- Sorted out issue with known hosts file and persistent storage

## 2023.6.2

- Quote fixing in timestamp command

## 2023.6.1

- Fixing ssh issues and updating rsynch command

## 2023.6.0

- Changed SSH login to only create a key, not adding via ssh-copy-id
- Changed storage path to persisten storage for ssh pubkey
- Always create ssh keys even if the backup function is disabled

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
