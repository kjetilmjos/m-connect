# m-connect

Remote connection client for home-assistant. Based on the wireguard addon developed by frenc
https://github.com/hassio-addons/addon-wireguard

# Usage instructions

Options:
Host = The IP of the wireguard master
Port = The Wireguard port configured on the wireguard master
PublicKey = The publick key for the wireguard master
Tunnelip = The tunnel IP for the client in form of 192.168.45.2/24

# DEV Install instructions

Follow the instructions to download and install the Remote Containers VS Code extension.
Copy the devcontainer.json file to .devcontainer.json in your repository.
Copy the tasks.json file to .vscode/tasks.json in your repository.
Open the root folder inside VS Code, and when prompted re-open the window inside the container (or, from the Command Palette, select 'Rebuild and Reopen in Container').
When VS Code has opened your folder in the container (which can take some time for the first run) you'll need to run the task (Terminal -> Run Task) 'Start Home Assistant', which will bootstrap Supervisor and Home Assistant.
You'll then be able to access the normal onboarding process via the Home Assistant instance at http://localhost:7123/.
The add-on(s) found in your root folder will automatically be found in the Local Add-ons repository.

To look into files that are created inside the addon sudo docker ps
find ID of the visual studio container
sudo docker exec -it <<VS contianer ID>> /bin/bash
Then sudo docker ps again and find id of addon you created. Then
sudo docker exec -it <<addon contianer ID>> /bin/bash

# testing

After doing changes to the code you have to do the following.
Addon store and check for updates. Then refresh browser

# IP range
Maximum 31 clients in the network. 
Picked a range that is not going to be used on the home router
10.170.204.0/27

10.170.204.0 - 10.170.204.31