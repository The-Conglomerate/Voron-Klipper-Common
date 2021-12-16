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

# Step 2: Add moonraker config
update_moonraker()
{
    echo -e "Adding update manager to moonraker.conf"

    update_section=$(grep -c '\[update_manager voron_klipper_common\]' \
    ${HOME}/klipper_config/moonraker.conf || true)
    if [ "${update_section}" -eq 0 ]; then
        echo -e "\n" >> ${HOME}/klipper_config/moonraker.conf
        while read -r line; do
            echo -e "${line}" >> ${HOME}/klipper_config/moonraker.conf
        done < "$PWD/file_templates/moonraker_update.txt"
        echo -e "\n" >> ${HOME}/klipper_config/moonraker.conf
    else
        echo -e "[update_manager voron_klipper_common] already exist in moonraker.conf [SKIPPED]"
    fi
}
# Step 3: Create macros and configs directories
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

# Step 4: link macros and configs
create_links()
{
    echo "Linking common directories to klipper_config..."
    if [ ! -L "${KLIPPER_CONFIG_PATH}/macros/common" ]; then
        echo "Creating macros/common link..."
        ln -s "${SRCDIR}/macros" "${KLIPPER_CONFIG_PATH}/macros/common"
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

# Step 5: create printer_variables.cfg
create_printer_variables_cfg()
{
    if [ ! -f "${KLIPPER_CONFIG_PATH}/printer_variable.cfg" ]; then
        echo "Creating ${KLIPPER_CONFIG_PATH}/printer_variable.cfg"
        cp "${SRCDIR}/file_templates/printer_variable.cfg.dist" "${KLIPPER_CONFIG_PATH}/printer_variable.cfg"
    fi
}

# Step 6: restarting Klipper
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
update_moonraker
create_dirs
create_links
create_printer_variables_cfg
restart_klipper
