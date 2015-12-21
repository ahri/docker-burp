#!/bin/sh

set -ue

mute=1

output()
{
    [ $mute -ne 0 ] && return
    echo "$@"
}

cd /host_cur_dir

if [ $# -gt 0 ]; then
    java -jar /burp-config.jar "$@"
fi

mkfifo /tmp/ctrl
tail -f /tmp/ctrl | java -jar "/burp.jar" | while read line; do
    if [ "$line" = "Do you accept the license agreement? (y/n)" ]; then
        mute=0
        echo y >> /tmp/ctrl
    elif [ "$line" = "This version of Burp requires a license key. To continue, please paste your license key below." ]; then
        echo $BURP_LICENSE >> /tmp/ctrl
    elif [ "$line" = "Enter preferred activation method (o=online activation; m=manual activation; r=re-enter license key)" ]; then
        echo o >> /tmp/ctrl
    else
        output "$line"
    fi
done
