#!/bin/sh
###############################
#
# Little example
#
#
##############################

if [ -z "$WPAS_STATE" ]; then
    echo "Error!!!"
    exit 1
fi

case $WPAS_STATE in
    
    COMPLETED)
	dhcpcd -x $WPAS_IFNAME
	dhcpcd -b $WPAS_IFNAME
	;;

    ASSOCIATING)
	# bad but fonctionnal (tested only on WEP and NONE keys)
	if [ $WPAS_SSID = 'unprotected_wireless' ]; then
	    ifconfig $WPAS_IFNAME down
	    macchanger -A $WPAS_IFNAME
	    ifconfig $WPAS_IFNAME up
	fi
	;;

#    SCANNING)
#	;;

#    DISCONNECTED)
#	;;

#    *)
#	;;
esac

echo "At $(date) state is $WPAS_STATE wpas env are: $(env | grep WPAS)" >> /var/log/wpa_supplicant-events.log
exit 0
