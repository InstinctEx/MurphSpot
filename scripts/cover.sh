#!/bin/bash

id_current=$(cat ~/.conky/murphspot/current/current.txt)
id_new=`~/.config/.conky/murphspot/scripts/id.sh`
cover=
imgurl=
dbus=`busctl --user list | grep "spotify"`

if [ "$dbus" == "" ]; then
       `cp ~/.config/.conky/murphspot/empty.jpg ~/.config/.conky/murphspot/current/current.jpg`
	echo "" > ~/.config/.conky/murphspot/current/current.txt
else
	if [ "$id_new" != "$id_current" ]; then

		echo $id_new > ~/.config/.conky/murphspot/current/current.txt
		imgname=`cat ~/.config/.conky/murphspot/current/current.txt | cut -d '/' -f5`

		cover=`ls ~/.config/.conky/murphspot/covers | grep "$id_new"`

		if grep -q "${imgname}" <<< "$cover"
		then
			`cp ~/.config/.conky/murphspot/covers/$imgname.jpg ~/.config/.conky/murphspot/current/current.jpg`
		else
			imgurl=`~/.config/.conky/murphspot/scripts/imgurl.sh`
			`wget -q -O ~/.config/.conky/murphspot/covers/$imgname.jpg $imgurl &> /dev/null`
			`touch ~/.conky/murphspot/covers/$imgname.jpg`
			`cp ~/.config/.conky/murphspot/covers/$imgname.jpg ~/.config/.conky/murphspot/current/current.jpg`
			# clean up covers folder, keeping only the latest X amount, in below example it is 10
			rm -f `ls -t ~/.config/.conky/murphspot/covers/* | awk 'NR>10'`
			rm -f wget-log #wget-logs are accumulated otherwise
		fi
	fi
fi
