#!/usr/bin/sh
# Short script to fetch based on supplied URL, manifest file and archive.
# Fetches manifest, performs a sync and creates an archive with the manifest contained.
#
URL=$1
MANIFEST=$2
ARCHIVE=$3

printf "Fetching files based on supplied manifest"

repo init -u $1 \-m $2
# This performs the same as the example command below.
#repo init -u https://github.com/seL4/sel4test-manifest.git -m default.xml

# sync the projects based on the revision in the manifest
repo sync -d

printf '\n'
printf "Will create archive of projects now"
printf '\n'
printf "These projects will be added to the archive"
printf '\n'
repo list -p
printf '\n'

# This was used to test the script, could be left in if interactive required.
#read -p "Is this list of projects correct? " response
#case ${response} in
#   y|Y)
#      echo "Creating archive $3 now"
#      repo list -p | xargs tar cvf $3
#   ;;
#   n|N)
#      echo "Exiting"
#   ;;
#esac

echo "Creating archive $3 now"
repo list -p | xargs tar cvf $3
printf '\n'
printf "Adding manifest file to archive"
printf '\n'
tar -vrf $3 ./.repo/.manifest.xml
printf "Compressing archive"
printf '\n'
gzip $3
