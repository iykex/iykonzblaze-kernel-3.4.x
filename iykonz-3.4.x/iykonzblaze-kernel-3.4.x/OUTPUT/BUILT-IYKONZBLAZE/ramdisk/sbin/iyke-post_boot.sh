#!/system/bin/sh
#

BB=/sbin/bb/busybox;

############################
# Custom Kernel Settings for CrazySuperKernel!
#
echo "Boot Script Started" | tee /dev/kmsg
stop mpdecision

############################
# MSM_MPDecision (Bricked) Hotplug Settings
#
echo 652800 > /sys/kernel/msm_mpdecision/conf/idle_freq
echo 1 > /sys/kernel/msm_mpdecision/conf/enabled

############################
# MSM Limiter
#
echo interactive > /sys/kernel/msm_limiter/scaling_governor_0
echo interactive > /sys/kernel/msm_limiter/scaling_governor_1
echo interactive > /sys/kernel/msm_limiter/scaling_governor_2
echo interactive > /sys/kernel/msm_limiter/scaling_governor_3
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_0
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_1
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_2
echo 300000 > /sys/kernel/msm_limiter/suspend_min_freq_3
echo 2265600 > /sys/kernel/msm_limiter/resume_max_freq_0
echo 2265600 > /sys/kernel/msm_limiter/resume_max_freq_1
echo 2265600 > /sys/kernel/msm_limiter/resume_max_freq_2
echo 2265600 > /sys/kernel/msm_limiter/resume_max_freq_3
echo 1190400 > /sys/kernel/msm_limiter/suspend_max_freq
echo 1 > /sys/kernel/msm_limiter/freq_control

############################
# CPU Input Boost
#
echo 1190400 1497600 > /sys/kernel/cpu_input_boost/ib_freqs
echo 1400 > /sys/kernel/cpu_input_boost/ib_duration_ms
echo 1 > /sys/kernel/cpu_input_boost/enabled

############################
# MISC Tweaks
#
echo 1 > /sys/module/state_notifier/parameters/enabled
echo 0 > /sys/kernel/sched/gentle_fair_sleepers
echo 1 > /sys/module/workqueue/parameters/power_efficient

############################
# Scheduler and Read Ahead
#
echo tripndroid > /sys/block/mmcblk0/queue/scheduler
echo 1024 > /sys/block/mmcblk0/bdi/read_ahead_kb

############################
# Adreno Idler
#
echo 2500 > /sys/module/adreno_idler/parameters/adreno_idler_idleworkload
echo 100 > /sys/module/adreno_idler/parameters/adreno_idler_idlewait
echo 50 > /sys/module/adreno_idler/parameters/adreno_idler_downdifferential
echo 1 > /sys/module/adreno_idler/parameters/adreno_idler_active

############################
# Simple GPU Algorithm
#
echo 2 > /sys/module/simple_gpu_algorithm/parameters/simple_laziness
echo 7000 > /sys/module/simple_gpu_algorithm/parameters/simple_ramp_threshold
echo 0 > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate

############################
# Sound Control
#
echo 1 > /sys/kernel/sound_control_3/lge_stweaks_control
echo 254 254 > /sys/kernel/sound_control_3/lge_headphone_gain
echo 0 0 > /sys/kernel/sound_control_3/lge_speaker_gain
echo 0 > /sys/kernel/sound_control_3/lge_mic_gain
echo 0 > /sys/kernel/sound_control_3/lge_cam_mic_gain

############################
# Init.d
#
$BB run-parts /system/etc/init.d;

############################
# Sepolicy
#
if [ -e /system/lib/libsupol.so ]; then
/system/xbin/supolicy --live \
	"allow untrusted_app debugfs file { open read getattr }" \
	"allow untrusted_app sysfs_lowmemorykiller file { open read getattr }" \
	"allow untrusted_app sysfs_usb_supply dir { search }" \
	"allow untrusted_app persist_file dir { open read getattr }" \
	"allow debuggerd gpu_device chr_file { open read getattr }" \
	"allow netd netd capability fsetid" \
	"allow netd { hostapd dnsmasq } process fork" \
	"allow { system_app shell } dalvikcache_data_file file write" \
	"allow { zygote mediaserver bootanim appdomain }  theme_data_file dir { search r_file_perms r_dir_perms }" \
	"allow { zygote mediaserver bootanim appdomain }  theme_data_file file { r_file_perms r_dir_perms }" \
	"allow system_server { rootfs resourcecache_data_file } dir { open read write getattr add_name setattr create remove_name rmdir unlink link }" \
	"allow system_server resourcecache_data_file file { open read write getattr add_name setattr create remove_name unlink link }" \
	"allow system_server dex2oat_exec file rx_file_perms" \
	"allow mediaserver mediaserver_tmpfs file execute" \
	"allow drmserver theme_data_file file r_file_perms" \
	"allow zygote system_file file write" \
	"allow atfwd property_socket sock_file write" \
	"allow debuggerd app_data_file dir search" \
	"allow mediaserver mediaserver_tmpfs:file { read write execute }"
fi;

############################
# Done!
#
echo "Exiting post-boot script" | tee /dev/kmsg
