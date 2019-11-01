# Couchbase
Repo download and archive script.

Contains a unix shell script, assumes git and the git repo tool are available.
This script can be used to download and archive code specified within a given manifest file.

The script takes two input parameters, the URL and manifest file name.

It first downloads the manifest file, then uses repo to sync the content specified in the manifest.
The script then builds a tar file of the projects based on the listing given by a repo list command.
Finally it adds the manifest file to the tar file.


