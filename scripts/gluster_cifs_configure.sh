#!/bin/bash
# Name: gluster_cifs_configure.sh
# Author: Chuck Gilbert <chuck.gilbert@oracle.com>
# Description: This script takes an existing GlusterFS Volume,
#   and enables CIFS export of the volume for access of windows clients.
#

# Exit on any errors
set -e

# Source Functions
source functions

# print_usage(): Function to print script usage
function print_usage() {
  echo "$0 -v volume -m \"masternode ip address\" -n \"list of workernode addresses\" -b \"brick path\""
  echo "Example: $0 -v examplevolume -m 1.1.1.1 -n \"1.1.1.2 1.1.1.3 1.1.1.4\" -b \"/brick/mybrick\""
  exit 1
}

# Check Arg Length
if [ "$#" = 0 ]
then
  print_usage
fi

# Get Commandline Options
while getopts ":v:m:n:b" opt; do
  case $opt in
  v)
    VOLNAME=$OPTARG
    ;;
  m)
    MASTER_NODE=$OPTARG
    ;;
  n)
    NODE_LIST=$OPTARG
    ;;
  b)
    BRICK=$OPTARG
    ;;
  \?)
    echo "Invalid option: -$OPTARG" >&2
    print_usage
    ;;
  esac
done

echo $VOLNAME
echo $NODE_LIST

create_ctdb_volume "$VOLNAME" "$NODE_LIST"

# end of script