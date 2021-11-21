# Voron-Klipper-Macros

Common klipper configs, macros, and scripts for Voron printers. 


## Install

```
> ssh <yourpiaddress>
> git clone https://github.com/The-Conglomerate/Voron-Klipper-Common.git
> cd ~/Voron-Klipper-Common
> ./install.sh
```

> Modify your `printer.cfg` to load config, the common macros, then your custom macros. This will allow you to override any config or macro if you choose.

``` 
...

[include configs/common/*.cfg] # Load common configs first
[include configs/*.cfg]
[include macros/common/*.cfg] # Load common macros first
[include macros/*.cfg]

...
```

## Moonraker Updater
> Modify your `moonraker.cfg` to be notified of updates and install them via view you Web UI.

```
[update_manager voron-klipper-common]
type: git_repo
path: /home/pi/Voron-Klipper-Common
primary_branch: main
origin: https://github.com/The-Conglomerate/Voron-Klipper-Common.git
install_script: /home/pi/Voron-Klipper-Common/install.sh
```

## Usage

Coming soon