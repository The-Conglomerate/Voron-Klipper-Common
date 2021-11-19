# Voron-Klipper-Macros

## Usage

## Install

```
> ssh <yourpiaddress>
> git clone https://github.com/The-Conglomerate/Voron-Klipper-Common.git
> cd ~/Voron-Klipper-Common
> ./install.sh
```

> Modify your `printer.cfg` to load config, the common macros, then your custom macros. This will allow you to override common with yours if you choose.

``` 
...

[include configs/*.cfg]
[include macros/common/*.cfg] # Load https://github.com/The-Conglomerate/Voron-Klipper-Macros first
[include macros/*.cfg]

...
```

> Modify your `moonraker.cfg` to be notified of updates and install them.

```
[update_manager voron-klipper-common]
type: git_repo
path: ~/Voron-Klipper-Common
origin: https://github.com/The-Conglomerate/Voron-Klipper-Common.git
install_script: install.sh
```