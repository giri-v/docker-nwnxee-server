## Neverwinter Nights Enhanced Edition NWNX Docker Image

This project provides a Docker multistage build that adds the NWNX binaries to a nwserver docker image

#### Docker Multistage build

The Docker Multistage build executes the following:

* Passes arguments to specify the following:
    * NWN_VERSION - head start version
    * NWN_TAG - Image tag of the dedicated server base image
    * NWN_VERSION_SUFFIX - If needed a suffix that is appended to the NWN_VERSION if needed to identify the base image
* Creates a builder image that downloads the NWNX bineries for the specified version and unpacks them
* Creates the main imagefrom the specified dedicated server base image
* Copies the unpacked NWNX files from the builder image
* Copies the required start stcipts
* Sets environment variables and permissions
* Sets the startup command

Example

##### Build with NWNX CI / CD NWNX binaries
* Using provided shell script to build image
	`./scripts/build-nwnx-image.sh -t glorwinger/nwserver:8152.1.nwnx -v 8152 -r glorwinger/nwserver -s .1`
* Using command line docker build
	`docker build -t glorwinger/nwserver:8152.bd.i386.nwnx --build-arg NWN_VERSION=8152 --build-arg NWN_TAG=glorwinger/nwserver --build-arg NWN_VERSION_SUFFIX=.1 . -f Dockerfile.nwnx`

##### Build with local NWNX binaries in Binaries folder

* Using provided shell script to build image
	`./scripts/build-nwnx-image.sh -l -t glorwinger/nwserver:8152.1.nwnx -v 8152 -r glorwinger/nwserver -s .1`
* Using command line docker build
	`docker build -t glorwinger/nwserver:8152.bd.i386.nwnx --build-arg NWN_VERSION=8152 --build-arg NWN_TAG=glorwinger/nwserver --build-arg NWN_VERSION_SUFFIX=.1 . -f Dockerfile.nwnx.local`


