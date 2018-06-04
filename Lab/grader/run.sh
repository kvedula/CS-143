#!/bin/bash

if [ "$#" -ne 1 ] || ! [ -f "$1" ]; then
	>&2 echo "Usage: $0 SUBMISSION"
	exit -1
fi

fn=$1
bn=$(basename "$fn")
# echo $bn
re="^([A-Za-z[:digit:]][[:digit:]]{7}).*\.[Zz][Ii][Pp]"
if [[ $bn =~ $re ]]; then
	echo "Student ID: ${BASH_REMATCH[1]}"
else
	>&2 echo "Cannot match student ID in file name."
	exit -2
fi
sid=${BASH_REMATCH[1]}
dn="s_$sid"

if [ -e submission ]; then
	>&2 echo "Unexpected submission file/folder in working directory."
	exit -3
fi
if [ -e "$dn" ]; then
	>&2 echo "Target directory already exists."
	exit -3
fi

# Attempt to extract files
unzip "$fn"
if ! [ -d submission ]; then
	>&2 echo "Invalid ZIP archive."
	exit -4
fi
mv submission "$dn"

# Attempt to run batch
pwd_init=$(pwd)
cp batch.sh "$dn"
cd "$dn"
make
./batch.sh ../cases_public outs_public
cd "$pwd_init"

