#!/bin/bash
killall conky
sleep 2s	
conky -c $HOME/.config/conky/murphspot/Murphid.conf &> /dev/null &
