set -x

if [ ! -f /home/vagrant/.vbox_version ]; then
    echo "/home/vagrant/.vbox_version file not found"
    exit 1
fi
vbox_version=$(cat /home/vagrant/.vbox_version)

cd /tmp
vbfile="VBoxGuestAdditions_${vbox_version}.iso"

if [ ! -f /home/vagrant/${vbfile} ]; then
    echo "Downloading VirtualBox Guest Additions ISO"
    curl "http://download.virtualbox.org/virtualbox/${vbox_version}/${vbfile}" -o /home/vagrant/${vbfile}
    if [ $? -ne 0 ]; then
        echo "Unable to download VBGA ISO"
        exit 1
    fi
fi
mount -o loop /home/vagrant/${vbfile} /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

exit 0
