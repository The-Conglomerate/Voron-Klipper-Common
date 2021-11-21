#!/bin/bash
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
    echo "Creating macro and config directories in klipper_config..."
    mkdir -p "${SRCDIR}/macros" "${SRCDIR}/configs" "${SRCDIR}/scripts"
}

# Step 3: link macros and configs
create_links()
{
    echo "Linking macro and config to klipper_config..."
    if [ ! -f "${KLIPPER_CONFIG_PATH}/macros/common" ]; then
        ln -s "${SRCDIR}/macros" "${KLIPPER_CONFIG_PATH}/macros/common"
    fi
    if [ ! -f "${KLIPPER_CONFIG_PATH}/configs/common" ]; then
        ln -s "${SRCDIR}/configs" "${KLIPPER_CONFIG_PATH}/configs/common"
    fi
    if [ ! -f "${KLIPPER_CONFIG_PATH}/scripts/common" ]; then
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