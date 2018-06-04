#!/bin/bash

if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
	>&2 echo "Usage: $0 s_STUDENT"
	exit -1
fi

EXEC="ruby"

if ! >&2 type -p $EXEC; then
	>&2 echo "Ruby is not found."
	>&2 echo "Please install Ruby first."
	exit -2
fi

dn=$1
bn=$(basename "$dn")
re="^s_([A-Za-z[:digit:]][[:digit:]]{7})"
if [[ $bn =~ $re ]]; then
	echo "Student ID: ${BASH_REMATCH[1]}"
else
	>&2 echo "Cannot match student ID in file name."
	exit -3
fi
sid=${BASH_REMATCH[1]}

if ! [ -d "$bn/outs_public" ]; then
	>&2 echo "Cannot find output files for public cases."
	exit -4
fi

#$EXEC comp_all.rb refs_public "$bn/outs_public" "$sid"
$EXEC comp_all.rb refs_public "$bn/outs_public"
