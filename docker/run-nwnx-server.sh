#!/bin/bash

set -e

ROHOMEPATH=/nwn/home
HOMEPATH=/nwn/run

# Setup custom nwnx plugin folder 
if [ -d $ROHOMEPATH/nwnx ]; then
    if test -n "$(find $ROHOMEPATH/nwnx -name '*.so' -print -quit)"
    then
        echo "[*] Copying any custom NWNX plugins"
        cp -v $ROHOMEPATH/nwnx/*.so /nwn/nwnx
    fi
fi

/nwn/run-server.sh