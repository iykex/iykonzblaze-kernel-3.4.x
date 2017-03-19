# AnyKernel2 Ramdisk Mod Script 
# osm0sis @ xda-developers
# modified by NanaIykeQuame for iykozBlaze Kernels

## AnyKernel setup
# EDIFY properties
do.binaries=1
do.devicecheck=1
do.initd=1
do.ukm=1
do.cleanup=1
device.name2=d851

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
initd=/system/etc/init.d;
bindir=/system/bin;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 755 $ramdisk


## AnyKernel install
dump_boot;

# Init.d
cp -fp $patch/init.d/* $initd
chmod -R 755 $initd

# remove mpdecsion binary
mv $bindir/mpdecision $bindir/mpdecision-rm

# Properties
ui_print "Modifying properties...";
backup_file default.prop;
replace_string default.prop "ro.adb.secure=0" "ro.adb.secure=1" "ro.adb.secure=0";
replace_string default.prop "ro.secure=0" "ro.secure=1" "ro.secure=0";

# add frandom compatibility
backup_file ueventd.rc;
insert_line ueventd.rc "frandom" after "urandom" "/dev/frandom              0666   root       root\n";
insert_line ueventd.rc "erandom" after "urandom" "/dev/erandom              0666   root       root\n";

backup_file file_contexts;
insert_line file_contexts "frandom" after "urandom" "/dev/frandom		u:object_r:frandom_device:s0\n";
insert_line file_contexts "erandom" after "urandom" "/dev/erandom               u:object_r:erandom_device:s0\n";

# init.qcom.rc
backup_file init.g3.rc;
append_file init.g3.rc "iyke-post_boot" init.g3.patch;

write_boot;
## end install
