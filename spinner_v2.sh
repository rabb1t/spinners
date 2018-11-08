#!/usr/bin/env bash

# Created by Pavel Raykov aka 'rabbit' / 2018-11-08 (c)
# vim: set ai tabstop=4 expandtab shiftwidth=4 softtabstop=4 filetype=sh

# Description:
#
#   Simple spinner while waiting for
#   a completion of any running background task

width=40
perc=0
speed="0.06" # seconds
inc="$(echo "100/${width}" | bc -ql)"

echo -n "Installing.. 0% "

while [ $width -ge 0 ]; do
	printf "\e[0;93;103m%s\e[0m %.0f%%" "0" "${perc}"
	sleep $speed
	let width--
	perc="$(echo "${perc}+${inc}" | bc -ql)"
	perc="$(printf "%.3f" $perc)"
	if [ ${perc%%.*} -lt 10 ]; then
		printf "\b\b\b"
	else
		printf "\b\b\b\b"
	fi
done
echo
