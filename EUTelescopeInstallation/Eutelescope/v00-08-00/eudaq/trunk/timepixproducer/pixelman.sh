#!/bin/sh
abort=0;

echo -n "Checking FTDI Drivers..."
if [ -f "/usr/local/lib/libftd2xx.so" ] && [ -f "/usr/lib/libftd2xx.so" ] && [ -f "/usr/local/lib/libftd2xx.so.0.4.16" ]; then
 	echo " OK.";
else
	echo " NOT FOUND!";
	echo -n "Installing FTDI Drivers (requires root permissions)...";
	sudo cp _other_/drivers/libftd2xx.so.0.4.16 /usr/local/lib/ 
	sudo ln -s /usr/local/lib/libftd2xx.so.0.4.16 /usr/local/lib/libftd2xx.so 
	sudo ln -s /usr/local/lib/libftd2xx.so.0.4.16 /usr/lib/libftd2xx.so.0.4.16
	sudo ln -s /usr/local/lib/libftd2xx.so.0.4.16 /usr/lib/libftd2xx.so 
	echo " OK.\n"
	abort=1;
fi

echo -n "Checking FTDI Drivers permissions..."
if [ -f "/etc/udev/rules.d/pixelman.rules" ];  then
 	echo " OK.";
else
	echo " NOT FOUND!";
	echo -n "Setting permissions (requires root permissions)...";
	sudo cp _other_/drivers/pixelman.rules /etc/udev/rules.d/
	echo " OK.\n"
	abort=1;
fi
if [ $abort -eq 1 ]; then
	echo "Please disconnect and reconnect the devices and start Pixelman again.\n"
	exit 0;
fi

export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH
java -jar ./JMpxLoader.jar
