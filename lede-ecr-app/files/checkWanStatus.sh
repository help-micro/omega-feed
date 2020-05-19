#!/bin/sh

. /usr/share/libubox/jshn.sh

while true
do
        status=$(ubus call network.interface.wan status)
        json_load "$status"
        json_get_var "wan_up" "up"

        # MT300A specific
        wan_status=`swconfig dev switch0 port 0 get link | sed -r 's/.*link:([[:alnum:]]*).*/\1/'`

        # link down not triggered
        if [ "$wan_status" == "down" ] && [ $wan_up == 1 ]
        then
                ifdown wan
        # link up not triggered
        elif [ "$wan_status" == "up" ] && [ $wan_up == 0 ]
        then
                ifup wan
        fi
        
        # Up ppp link if required
        ppp_status=$(ubus call network.interface.ppp0 status)
        json_load "$ppp_status"
        json_get_var "ppp_up" "up"
        json_get_var "ppp_proto" "proto"
        if [ "$ppp_proto" == "ppp" ] && [ $ppp_up == 0 ]
        then
            /home/uart.sh
        fi
        sleep 5
done
