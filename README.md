# PowerShell HueNanoLeaf
Powershell scripts for recalling Hue and Nanoleaf scenes

This is a personal project to get a piece of awesome streaming software called Aitum to control my lights while waiting for official lighting support to be added (it's on their roadmap!).

It boils down to a handful of scripts that simply talk to the device on your network and tell it to recall a scene.

Everything should be kept self-contained in a folder, some scripts rely on other files in the same directory to function.


## Hue
The Hue folder contains the following scripts:

**authorisation.ps1** - This script is used to create a credential file that authenticates the scripts to your Hue bridge. It also stores your Bridge IP address.

**list_groups.ps1** - This gets a list of all the Groups in your Hue system, this is used to identify Scenes as you may have more than one Scene with the same name in different groups. Results are saved to a text file for later use. You will need to run this each time you add/change lights in your Hue system.

**list_scenes.ps1** - This gets a list of all the Scenes in your Hue system for recalling on command. Results are saved to a text file for later use. You will need to run this each time you add/change scenes on your Hue system.

**hue_switch.ps1** - This is the main script that handles switching scenes. It has two input parameters, the Group name and the Scene name.

### 1. Authorisation
First you will need to allow the script to talk to your Hue bridge. 
Before doing this, I recommend you set a static IP address for your bridge, as if the IP changes, the script will no longer find your bridge. 
Once you have done that, run the Authorisation.ps1 script. 
It will prompt you for the bridge IP. If the connection is successful, this is stored in **hue_device_ip.txt**. 
You will then need to press the button on your bridge (hold for a second or two just to be sure), then come back to the script and press Enter. This will start the authentication process. 
If successful a message will show and the user key will be saved to **hue_auth_token.txt**.

### 2. Create Group listing

### 3. Create Scene listing

### 4. Change Scenes

## Nanoleaf
The Nanoleaf folder contains the following scripts:

**authorisation.ps1** - This script is used to create a credential file that authenticates the scripts to your Nanoleaf device. It also stores your Nanoleaf device IP address.

**nanoleaf_switch.ps1** - This is the script that will switch to a different Nanoleaf scene. It has one input parameter - the scene name you want to switch to.

**nanoleaf_tempswitch.ps1** - This script will temporarily switch to a different scene for the number of seconds you input. It has two input parameters, the scene to swtich to, and how many seconds to show it for. It will then switch back to the original scene.

### 1. Authorisation

### 2. Change Scene

### 3. Temporarily Change Scene
