#!/bin/bash
#
# Copyright (c) 2017 mindsensors.com
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.    See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#mindsensors.com invests time and resources providing this open source code,
#please support mindsensors.com  by purchasing products from mindsensors.com!
#Learn more product option visit us @  http://www.mindsensors.com/

echo ""
echo "config file"
echo "----------------"
if [ -f /usr/local/mindsensors/conf/msdev.cfg ]
then
    cat /usr/local/mindsensors/conf/msdev.cfg
    homefolder=`grep homefolder /usr/local/mindsensors/conf/msdev.cfg | cut -d"=" -f2`
else
    echo "config file is missing"
    homefolder=/home/pi/PiStorms
fi
echo "homefolder: $homefolder"


#python3 $homefolder/programs/utils/msg-to-screen.py "Loading Raspbian" "Please wait"
echo "Running PiStorms Diagnostics"
echo "--------------------------"
echo ""
echo "Date..."
echo "-------"
date

echo ""
echo "PiStorms info "
echo "--------------"

if [ -f $homefolder/programs/utils/psm-info.py ]
then
    python3 $homefolder/programs/utils/psm-info.py
else
    echo "psm-info.py is missing"
fi

echo ""
echo "i2cdetect -y 1 0x03 0x74 output"
echo "-------------------------------"
i2cdetect -y 1 0x03 0x74
echo ""
echo "i2cdetect -y 1 0x76 0x77 output"
echo "-------------------------------"
i2cdetect -y 1 0x76 0x77

echo ""
echo "Voltage check..."
echo "----------------"

if [ -f $homefolder/programs/utils/print-battery-voltage.py ]
then
    echo "voltage check"
    python3 $homefolder/programs/utils/print-battery-voltage.py
else
    echo "print-battery-voltage.py is missing"
fi

#echo ""
#echo "Screen test....."
#echo "----------------"
#
#if [ -f /home/pi/PiStorms/programs/utils/screen-test.py ]
#then
#    python3 /home/pi/PiStorms/programs/utils/screen-test.py
#else
#    echo "screen-test.py is missing"
#fi

echo ""
echo "uname ...."
echo "----------"
uname -a

echo ""
echo "Network info ...."
echo "-----------------"
ifconfig -a

echo ""
echo "Ping test ...."
echo "-----------------"
ping -c 3 8.8.8.8

echo ""
echo "PiStorms Diagnostics test concluded...."
echo "---------------------------------------"
