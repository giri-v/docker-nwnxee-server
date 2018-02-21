#!/bin/bash

usage() { echo "$0 usage:" && grep " .)\ #" $0; exit 0; }

DOCKERFILE=Dockerfile.nwnx

while getopts ":hjt:v:z:" o; do
    case "${o}" in
        j) # Build image using including openjdk-8-headless
            DOCKERFILE=Dockerfile.nwnx.java
            JAVATAG=.java
            ;;
        v) # Headstart Build Number - eg 8159
            VERSION=${OPTARG}
            ;;
        z) # Location of the NWNX Libraries Zip File eg ./Binaries or https://21-117715326-gh.circle-artifacts.com/0/root/project/Binaries/NWNX-EE.zip
            NWNX_ZIP=${OPTARG}
            ;;
        h | *) # Display help
            usage
            exit 0
            ;;
    esac
done
shift $((OPTIND-1))

if [[ ( -z ${VERSION} ) || ( ${DOCKERFILE} == "Dockerfile.nwnx.java" && -n ${NWNX_ZIP} ) ]]; then
    echo ""
    echo "Required arguments -v <version> and either -j or -n <location of NWNX Library Zip File>"
    usage
    echo ""
fi

docker build -t nwnx/nwserver:${VERSION}${JAVATAG} --build-arg NWN_VERSION=${VERSION} --build-arg NWNX_ZIP=${NWNX_ZIP} . -f ${DOCKERFILE}
