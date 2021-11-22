#!/bin/bash
SRCDIR="${HOME}/Voron-Klipper-Common"
KLIPPER_CONFIG_PATH="${HOME}/klipper_config"
SYSTEMDDIR="/etc/systemd/system"

# Step 1:  Verify Klipper has been installed
check_klipper()
{
    if [ "$(sudo systemctl list-units --full -all -t service --no-legend | grep -F "klipper.service")" ]; then
        echo "Klipper service found!"
    else
        echo "Klipper service not found, please install Klipper first"
        exit -1
    fi

}

# Step 2: Create macros and configs directories
create_dirs()
{
    echo "Creating directories in klipper_config..."
    if [ ! -d "${KLIPPER_CONFIG_PATH}/macros" ]; then
        echo "Creating macros directory..."
        mkdir -p "${KLIPPER_CONFIG_PATH}/macros" 
    fi
    if [ ! -d "${KLIPPER_CONFIG_PATH}/configs" ]; then
        echo "Creating configs directory..."
        mkdir -p "${KLIPPER_CONFIG_PATH}/configs"
    fi
    if [ ! -d "${KLIPPER_CONFIG_PATH}/scripts" ]; then
        echo "Creating scripts directory..."
        mkdir -p "${KLIPPER_CONFIG_PATH}/scripts"
    fi
}

# Step 3: link macros and configs
create_links()
{
    echo "Linking common directories to klipper_config..."
    if [ ! -L "${KLIPPER_CONFIG_PATH}/macros/common" ]; then
        echo "Creating macros/common link..."
        ln -s "${SRCDIR}/macros/common" "${KLIPPER_CONFIG_PATH}/macros/common"
    fi
    if [ ! -L "${KLIPPER_CONFIG_PATH}/configs/common" ]; then
        echo "Creating configs/common link..."
        ln -s "${SRCDIR}/configs" "${KLIPPER_CONFIG_PATH}/configs/common"
    fi
    if [ ! -L "${KLIPPER_CONFIG_PATH}/scripts/common" ]; then
        echo "Creating scripts/common link..."
        ln -s "${SRCDIR}/scripts" "${KLIPPER_CONFIG_PATH}/scripts/common"
    fi
}

# Step 4: restarting Klipper
restart_klipper()
{
    echo "Restarting Klipper..."
    sudo systemctl restart klipper
}

# Helper functions
verify_ready()
{
    if [ "$EUID" -eq 0 ]; then
        echo "This script must not run as root"
        exit -1
    fi
}

# Force script to exit if an error occurs
set -e

# Find SRCDIR from the pathname of this script
SRCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/ && pwd )"

# Parse command line arguments
while getopts "k:" arg; do
    case $arg in
        k) KLIPPER_CONFIG_PATH=$OPTARG;;
    esac
done

# Run steps
verify_ready
create_dirs
create_links
restart_klipper