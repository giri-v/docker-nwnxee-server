#!/bin/bash

set -e

ROHOMEPATH=/nwn/home
HOMEPATH=/nwn/run

# Setup custom nwnx plugin folder 
if [ -d $ROHOMEPATH/nwnx ]; then
  echo "[*] Copying custom plugin(s) to nwnx folder"
  cp -v $ROHOMEPATH/nwnx/*.so /nwn/nwnx
fi

/nwn/run-server.sh