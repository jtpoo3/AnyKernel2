# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Kangaroo Kernel for Asus Nexus 7
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=flo
device.name2=deb
device.name3=
device.name4=
device.name5=
supported.versions=
'; } # end properties

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chmod -R 755 $ramdisk/sbin;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.flo.rc
insert_file init.flo.rc "KCAL configuration" before "setprop vold.post_fs_data_done 1" init.flo;

# fstab.flo
patch_fstab fstab.flo /data ext4 options "noatime,nosuid,nodev,barrier=1,data=ordered,nomblk_io_submit,errors=panic" "noatime,nosuid,nodev,barrier=1,data=ordered,nomblk_io_submit,errors=panic,noauto_da_alloc";
patch_fstab fstab.flo /cache ext4 options "noatime,nosuid,nodev,barrier=1,data=ordered,nomblk_io_submit,errors=panic" "noatime,nosuid,nodev,barrier=1,data=ordered,nomblk_io_submit,errors=panic,noauto_da_alloc";

# end ramdisk changes

write_boot;

## end install

