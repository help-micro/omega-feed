#!/bin/sh

# include the Onion sh lib
. /usr/lib/onion/lib.sh

case "$1" in
   list)
        echo '{"getDevices": {}, "scanStop": {}, "state": {}, "power": {}, "scan": {}, "pair": {}, "connect": {}, "disconnect": {}, "remove": {}, "set3G": {}, "getLeases": {}, "clearLeases": {}, "getUSBDevices": {}, "restartNetwork": {}}'
   ;;
   call)
        case "$2" in
			state)
				# return json object or an array
				/usr/bin/pybluez/get-adapter-state
			;;
			power)
				# read the arguments
				read input;
				
				json_load "$input"
				json_get_var "state" "state"
				/usr/bin/pybluez/set-adapter-state "$state"	
			;;
			scan)
				/usr/bin/pybluez/scan-devices
			;;
			pair)
				read input;
				json_load "$input"
				json_get_var "address" "address"
				/usr/bin/pybluez/pair "$address"
			;;
			connect)
				read input;
				json_load "$input"
				json_get_var "address" "address"
				/usr/bin/pybluez/connect-to-network "$address"
			;;
			disconnect)
				read input;
				json_load "$input"
				json_get_var "address" "address"
				/usr/bin/pybluez/connect-to-network "$address" 1
			;;
			remove)
				read input;
				json_load "$input"
				json_get_var "address" "address"
				/usr/bin/pybluez/remove-device "$address"
			;;
			set3G)
				read input;
				json_load "$input"
				json_get_vars section modemDevice modemService modemPinCode modemApn modemDialNumber modemUsername modemPassword modemPppdOptions

				uci set network.$section.device=$modemDevice
				uci set network.$section.service=$modemService
				uci set network.$section.pincode=$modemPinCode
				uci set network.$section.apn=$modemApn
				uci set network.$section.dialnumber=$modemDialNumber
				uci set network.$section.username=$modemUsername
				uci set network.$section.password=$modemPassword
				uci set network.$section.pppd_options=$modemPppdOptions
				uci commit
				echo '{"success": true}'
			;;
			getLeases)
				ip="192.168.8.100"
				record=$(cat /proc/net/arp | grep "$ip")
				delimiter=' '
				device='-'
				address='-'
				if [ ! -z "$record" ]
				then
								address=$(echo "$record" | awk -F ' ' '{print $4}')
				else
								ip='-'
				fi
				echo '{"ip": "'$ip'", "device": "'$device'", "address": "'$address'"}'


			;;
			clearLeases)
				echo "" > /tmp/dhcp.leases
				/etc/init.d/dnsmasq restart
				echo '{"success": true}'
			;;
			getUSBDevices)
				devices=$(ls /dev/ | grep tty[A-Z]* | while read line; do echo \""$line"\" ; done | tr '\n' ',' | sed '$ s/.$//')
				echo "{\"devices\":["$devices"]}"
			;;
			restartNetwork)
				/etc/init.d/network restart
				echo "{}"
			;;
			scanStop)
				killall scan-devices
				echo "{}"
			;;
			getDevices)
				/usr/bin/pybluez/get-devices
			;;

        esac
   ;;
esac

