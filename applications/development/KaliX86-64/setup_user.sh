#!/usr/bin/bash
# Must be run as root
# e.g., # ./setup_user.sh -u <USER> -H <HOME>

USER="NULL"
HOME="NULL"

while getopts ":hu:H:" opt; do
        case ${opt} in
                h )
                        echo "Usage:"
                        echo "  setup_user.sh -h         	Displays this help message."
                        echo "  setup_user.sh -u <USER> -H <HOME>   Finishes setup of <USER>."
                        exit 0
                        ;;
                u )
                        USER=$OPTARG
                        ;;
                H )
                        HOME=$OPTARG
                        ;;
                \? )
                        echo "Incorrect usage.  For help, run prepshutdown_netplan.sh -h"
                        exit 1
                        ;;
        esac
done

if [ $USER == "NULL" ] || [ $HOME == "NULL" ]; then
    echo "Usage:"
    echo "  setup_user.sh -h         	Displays this help message."
    echo "  setup_user.sh -u <USER> -H <HOME>   Finishes setup of <USER>."
    exit 0
fi

# Copy default files from /etc/skel and set ownership
cp -rT /etc/skel $HOME
chown -R $USER $HOME
chgrp -R $USER $HOME

# Change the default shell to bash for the user
chsh -s /bin/bash $USER

# Create a .gdbinit file with the specified content
echo "set disassembly-flavor intel" > $HOME/.gdbinit
echo "set disable-randomization on" >> $HOME/.gdbinit

# Ensure the correct ownership and permissions for .gdbinit
chown $USER $HOME/.gdbinit
chgrp $USER $HOME/.gdbinit

echo "User setup completed for $USER with home directory $HOME."

