#!/bin/sh
# script for assignment 1
# Author: Santiago Rodriguez

# Accepts the following runtime arguments: ,
# filesdir: the first argument is a path to a directory on the filesystem
# searchstr: the second argument is a text string which will be searched within these files
# 
# Example: $ ./finder.sh filesdir searchstr

INARGCNT=2

# Exits with return value 1 error and print statements if any of the parameters above were not specified
if [ $# -lt $((INARGCNT)) ]; then
    echo "Missing parameters: ($#) received, ($((INARGCNT))) expected"
	exit 1	
else
	# Assign values
    filesdir=$1
    searchstr=$2
fi
 
if [ ! -d $filesdir ]; then
    echo "'${filesdir}' does not represent a directory on the filesystem"
	exit 1	
fi

findRes=$( grep -Rch ${searchstr} ${filesdir} | awk 'BEGIN { matchCnt=0} { matchCnt += $0 }; END { printf "The number of files are %d and the number of matching lines are %d \n", NR,matchCnt }')

# Prints a message "The number of files are X and the number of matching lines are Y" where X is the number of files in the directory and all subdirectories and Y is the number of matching lines found in respective files, where a matching line refers to a line which contains searchstr (and may also contain additional content).
echo $findRes
