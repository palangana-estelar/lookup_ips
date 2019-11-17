#!/bin/bash

#######
# Give a list of 
# active connections, and then WHOIS to see who you are connected to
######
echo -e ' \nBelow is a list of ips with active TCP connections to you \n'
#netstat -tunapl | awk '{ print $5 }' | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | sort | uniq

# netstat (macos syntax) to get all open tcp connection
# then grep only remote addresses
# used grep because awk includes table info from netsta result
# then sort and uniq to remove duplicate ips
echo -e '\nYou are connected to: \n'
for i in $(netstat -tunapl | awk '{ print $5 }' | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | sort | uniq); do
	#echo "\n"
	echo $i
	whois $i | grep -e OrgName -e Country -e CIDR
	echo -e '----------------- '
done
