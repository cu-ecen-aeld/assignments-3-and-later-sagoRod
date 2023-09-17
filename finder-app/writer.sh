#!/bin/sh
# script for assignment 1
# Author: Santiago Rodriguez

# Accepts the following arguments:
# writefile: the first argument is a full path to a file (including filename) on the filesystem
# writestr: the second argument is a text string which will be written within this file
# 
# Example: $ writer.sh /tmp/aesd/assignment1/sample.txt ios

INARGCNT=2

# Exits with value 1 error and print statements if any of the arguments above were not specified
if [ $# -lt $((INARGCNT)) ]; then
    echo "Missing parameters: ($#) received, ($((INARGCNT))) expected"
	exit 1	
else
	# Assign values
    writefile=$1
    writestr=$2
fi

# Creates a new file with name and path writefile with content writestr, overwriting any existing file and creating the path if it doesn't exist. Exits with value 1 and error print statement if the file could not be created.

writedir=${writefile%/*}

if [ ! -d writedir ]; then
    mkdir -p ${writedir}
fi

echo ${writestr} > ${writefile}

res=$?
if [ ${res} -ne 0 ]; then
    echo ${res}
    echo "Write operation failed!"
	exit 1	
fi

# cat ${writefile}
