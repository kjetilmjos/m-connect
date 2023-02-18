# Home Assistant Add-on: m-connect

Wireguard client for Home Assistant

# About

m-connect is a wireguard client for connecting Home Assistant to a remote wireguard server.
Remote connection client for home-assistant. The use case is to have a wireguard server in the cloud with a proxy like traefik or nginx to do SSL resolving and forward requests to the correct wireguard client (Home Assistant instance).

The default IP range configured is to have the wireguard master running 10.170.204.1/27 which gives a maximum of 31 clients in the range 10.170.204.2-10.170.204.31
The range is selected to not interfer with standard home router IP ranges

# Development

To set up a local development environment use dev container in visual studio code.
Open the root folder inside VS Code, and when prompted re-open the window inside the container (or, from the Command Palette, select 'Rebuild and Reopen in Container').
When VS Code has opened your folder in the container (which can take some time for the first run) you'll need to run the task (Terminal -> Run Task) 'Start Home Assistant', which will bootstrap Supervisor and Home Assistant.
You'll then be able to access the normal onboarding process via the Home Assistant instance at http://localhost:7123/.
The add-on(s) found in your root folder will automatically be found in the Local Add-ons repository.

To look into files that are created inside the addon sudo docker ps. This has to be runned in VS code in the terminal for the VS developer container.
find ID of the visual studio container
sudo docker exec -it <<VS contianer ID>> /bin/bash
Then sudo docker ps again and find id of addon you created. Then
sudo docker exec -it <<addon contianer ID>> /bin/bash

## Update version

When you have a new version of the code you want to test, set a new version of the code in the config.yaml file.
In the addon store select check for updates.
Refresh the browser and the update should be possible to install.

# Acknowledgements

Based on the wireguard addon developed by frenc
https://github.com/hassio-addons/addon-wireguard
