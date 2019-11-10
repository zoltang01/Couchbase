# Couchbase
Repo download and archive script.

Contains a unix shell script, assumes git and standard linux environment is available.
This script can be used to download and archive code specified within a given manifest file.

The script takes two input parameters, the manifest file URL name and the target archive.
Example:

$ ./backup-manifest.sh https://raw.githubusercontent.com/couchbase/sync_gateway/master/manifest/default.xml archive.tar

It first downloads the manifest file, then processes the manifest file to determine the projects required, project name, path to store the project, the revision and the remote clone url.

The repos are cloned to local storage, where appropriate the correct revision is selected otherwise defaults to master.

The script then builds a tar file of the projects excluding the .git subdirectories.
Finally it adds the manifest file to the tar file and compress the tar file.


