# Couchbase
Repo download and archive script.

Contains a unix shell script, assumes git and the git repo tool are available.
This script can be used to download and archive code specified within a given manifest file.

The script takes three input parameters, the URL, manifest file name and the target archive.
Example:
$ ./backup-manifest.sh  https://github.com/couchbase/sync_gateway.git manifest/default.xml archive1.tar

It first downloads the manifest file, then uses repo to sync the content specified in the manifest.
The script then builds a tar file of the projects based on the listing given by a repo list command.
Finally it adds the manifest file to the tar file and compress the tar file.


