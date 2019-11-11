##!/usr/bin/sh
#
#
# Short script to fetch based on supplied URL and manifest file.
# Fetches manifest, performs a sync and creates an archive with the manifest contained.
#
MANIFEST=$1
ARCHIVE=$2

base='https://github.com/'
name=' '
path=' '
remote=' '
revision=' '
scriptdir=$(PWD)
tarcmd='tar cvf'

printf "Will fetch files based on supplied manifest"
printf "Running here:" $scriptdir
wget $1

printf "Process manifest file and fetch, then archive"

#Generate list of projects from manifest, loop through, find details and checkout versions.

for path in $(grep "project name" ./default.xml| cut -d '"' -f 4); do
  echo -e "Project $path"  
  #Find project name
  echo "Finding project name:"
  name=$(grep "$path" ./default.xml | awk -F"name=" '{print $2}' | awk -F"\"" '{print $2}') 
  echo $name

  #Find project path
  echo "Finding project path:"
  #path=$(grep "$path" ./default.xml | cut -d '"' -f 4)
  path=$(grep "$path" ./default.xml | grep -E -o "(\".*?\")" | awk -F"path=" '{print $2}' | awk -F"\"" '{print $2}') 
  echo $path

  #Find project remote
  echo "Finding project remote:"
  #remote=$(grep "$path" ./default.xml | cut -d '"' -f 6)
  remote=$(grep "$path" ./default.xml | grep -E -o "(\".*?\")" | awk -F"remote=" '{print $2}' | awk -F"\"" '{print $2}')
  fullremote="$base$remote/$name.git"
  echo $fullremote


  #Find project revision
  echo "Finding manifest revision:"
  #revision=$(grep "$path" ./default.xml | cut -d '"' -f 8)
  revision=$(grep "$path" ./default.xml | grep -E -o "(\".*?\")" | awk -F"revision=" '{print $2}' | awk -F"\"" '{print $2}')
  echo $revision

  echo -e "\n"
  #Checkout
  echo "Checking out project:" 
  git clone $fullremote $path
  echo "Checking out manifest revision:"
  cd $path
  git checkout $revision
  rm -Rf ./.git
  cd $scriptdir
  echo "Returning to script directory:" $scriptdir 

done

echo "Creating archive $2 now"
ls | xargs $tarcmd $2
printf '\n'
printf "Adding manifest file to archive"
printf '\n'
printf "Compressing archive"
printf '\n'
gzip $2

