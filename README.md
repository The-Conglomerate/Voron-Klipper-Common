# Voron-Klipper-Macros

![The Conglomerate](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Society.svg/400px-Society.svg.png)

Common klipper configs, macros, and scripts for Voron printers.

# Table of Contents
**(!)** = has important warning
- [**(!)** Change Log](#change-log)
- [Install](#install)
- [Moonraker Updater](#moonraker-updater)
- [Usage](#usage)
- [Install](#install)
- [Credits](#credits)

# Change Log

Changes will be noted here by date, title if needed, files changed, summary of changes.

_**Note: only changes of signifigance will be added.**_

- **2021-XX-XX:** (v1.0) _The One Where It All Began_.


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
[include printer_variable.cfg]

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
is_system_service: False
```

## Usage



# Credits

* [alch3my's frame expansion script](https://github.com/Klipper3d/klipper/pull/4157)
* [eecue's klipper_configs](https://github.com/eecue/klippper-config)
* [zellneralex's klipper_configs](https://github.com/zellneralex/klipper_config)
* [FHeilmann's klipper_configs](https://github.com/FHeilmann/klipper_config/)
* [th33xitus/kiauh klipper github backup](https://github.com/th33xitus/kiauh/wiki/How-to-autocommit-config-changes-to-github%3F)
* [Ette's enraged rabbit carrot feeder macro's for filament unload](https://github.com/EtteGit/EnragedRabbitProject)
