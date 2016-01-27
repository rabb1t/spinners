#!/usr/bin/env bash

# Created by Pavel Raykov aka 'rabbit' / 2016-01-26 (c)
# $Id$

# Description:
#
#	Simple spinner while waiting for
#	a completion of any running background task

SPIN_DELAY=0.05
TIMEOUT=30

pos=0
char=">"
dots_a="........"
dots_b=""
dots_count="${#dots_a}"
limit=$[dots_count*2]

printSpinner()
{   
    local repeat="$( printf "%.0f\n" `echo "1 / $SPIN_DELAY" | bc -ql` )"
    local dot="${dots_a:0:1}"

    if which bc &>/dev/null; then
	while [ "$repeat" -gt 0 ]; do
	    printf "["
	    printf "%s" "$dots_b"
	    printf "%c" "$char"
	    printf "%s" "$dots_a"
	    printf "]"

	    sleep $SPIN_DELAY

	    printf "\b\b\b\b\b\b\b\b\b\b\b"

	    if [ $pos -lt $dots_count ]; then
		char=">"
		dots_a="${dots_a%?}"
		dots_b+="$dot"
		let pos++
	    elif [ $pos -lt $limit ]; then
		char="<"
		dots_b="${dots_b%?}"
		dots_a+="$dot"
		let pos++
	    else
		char='>'
		pos=0
	    fi

	    let --repeat
	done
    else
	# Use sleep(1) if `bc' doesn't installed
        sleep $SPIN_DELAY
    fi
}

printf "Please wait..\t"

n=0
while [ $n -lt $TIMEOUT ]; do
    printSpinner
    let n++
done
echo

exit 0

# EOF

