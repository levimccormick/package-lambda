#!/bin/sh
set -e

FILENAME="`sha1sum /code/* | sha1sum | awk '{print $1}'`.zip"
echo "Checking for $FILENAME"
if test -f "/output/$FILENAME"; then
    echo "$FILENAME exists"
else
    echo "Removing old deployment."
    rm /output/* || true
    echo "Packing python3 code..."
    echo "make tmpdir"
    mkdir -p /tmpdir
    echo "adding code to build"
    rsync -a /code/ /tmpdir --exclude tmpdir --exclude .git
    
    # step into tmpdir
    cd /tmpdir
    mkdir /virtual-env
    virtualenv /virtual-env
    source /virtual-env/bin/activate
    /virtual-env/bin/pip3.7 install -r requirements.txt -t .
    
    echo "Copy site_packages into the dir that we are pushing our pip stuff into..."
    rsync -a /virtual-env/lib/python3.7/site-packages/* . --exclude wheel* --exclude setuptools --exclude pkg_resources --exclude pip
    echo "Zipping up"
    zip -r9q --exclude=*.pyc* --exclude=*deployment.zip* --exclude=*entrypoint.sh* /output/deployment.zip .
    cd /output
    mv `ls` $FILENAME
    chown -R 501:501 *
fi