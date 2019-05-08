#!/system/bin/sh
#########################################################################
# File Name: run_ftrace_log.sh
# after catch ftrace log successfully, adb pull /sdcard/power_logs .
#########################################################################

echo "[`date +%Y%m%d_%H-%M-%S`] ====== $0: PID of this script: $$ ======\n"

SAVE_LOG_ROOT=/sdcard/power_logs
SAVE_LOG_PATH="$SAVE_LOG_ROOT/`date +%Y_%m_%d_%H_%M_%S`"

function set_environment() {
    rm -rf $SAVE_LOG_ROOT
    mkdir -p $SAVE_LOG_PATH
    chmod -R 777 $SAVE_LOG_PATH
    chmod -R 777 $SAVE_LOG_ROOT

    cat /proc/kmsg > $SAVE_LOG_PATH/kernel_kmsg.log &
    logcat -v threadtime -b all > $SAVE_LOG_PATH/loagcat_all.log &
}

function enable_debug_log() {
    echo 0 > /d/tracing/tracing_on 

    echo 70000 > /d/tracing/buffer_size_kb
    echo "[/d/tracing/buffer_size_kb] : "
    cat /d/tracing/buffer_size_kb

    echo "" > /d/tracing/set_event
    echo "" > /d/tracing/trace

    echo power:cpu_idle power:cpu_frequency power:cpu_frequency_switch_start msm_low_power:* sched:sched_cpu_hotplug sched:sched_switch sched:sched_wakeup sched:sched_wakeup_new sched:sched_enq_deq_task >> /sys/kernel/debug/tracing/set_event
    echo power:memlat_dev_update power:memlat_dev_meas msm_bus:bus_update_request msm_bus:* power:bw_hwmon_update power:bw_hwmon_meas >> /sys/kernel/debug/tracing/set_event
    echo power:bw_hwmon_meas power:bw_hwmon_update>> /sys/kernel/debug/tracing/set_event
    echo clk:clk_set_rate clk:clk_enable clk:clk_disable >> /sys/kernel/debug/tracing/set_event
    echo power:clock_set_rate power:clock_enable power:clock_disable msm_bus:bus_update_request >> /sys/kernel/debug/tracing/set_event
    echo cpufreq_interactive:cpufreq_interactive_target cpufreq_interactive:cpufreq_interactive_setspeed >> /sys/kernel/debug/tracing/set_event
    echo irq:* >> /sys/kernel/debug/tracing/set_event
    echo mdss:mdp_mixer_update mdss:mdp_sspp_change mdss:mdp_commit >> /sys/kernel/debug/tracing/set_event
    echo workqueue:* >> /sys/kernel/debug/tracing/set_event
    echo kgsl:kgsl_pwrlevel kgsl:kgsl_buslevel kgsl:kgsl_pwr_set_state >> /sys/kernel/debug/tracing/set_event
    echo regulator:regulator_set_voltage_complete regulator:regulator_disable_complete regulator:regulator_enable_complete >> /sys/kernel/debug/tracing/set_event
    echo thermal:* >> /sys/kernel/debug/tracing/set_event

    #Confrim the setting
    echo "\n[/d/tracing/set_event] : "
    cat /d/tracing/set_event
}


set_environment
enable_debug_log
echo 1000 > /sys/class/timed_output/vibrator/enable


echo "\n[`date +%Y%m%d_%H-%M-%S`] remove USB and start your test case within 10s\n"
# Give the below commands before disconnecting the USB and once you completed the 120 secs test then connect the USB. 
# Once the below commands are executed , make sure you start your test case within 10 secs. 
sleep 10

echo 1 > /d/tracing/tracing_on
sleep 120
echo 0 > /d/tracing/tracing_on
cat /d/tracing/trace > $SAVE_LOG_PATH/trace_wakeup.txt

#adb shell "echo test > sys/power/wake_lock"
cat /d/clk/enabled_clocks > $SAVE_LOG_PATH/enabled_clocks.txt



sync
echo "[`date +%Y%m%d_%H-%M-%S`] ====== $0: Successful execution ! ======\n"
echo 1000 > /sys/class/timed_output/vibrator/enable
input keyevent POWER
sync