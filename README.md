## Neverwinter Nights Enhanced Edition NWNX Docker Image

This project provides two image builds:
* Docker NWNX multistage build that adds the NWNX binaries to a nwserver docker image
* Docker NWNX Java build that adds the OpenJDK to the NWNX Image

#### Docker Multistage build for NWNX base image

The Docker Multistage build executes the following:

* Pass arguments to specify the following:
	* -v NWN_VERSION - Head start version
	* -z NWNX_ZIP - Location of the NWNX Libraries Zip File eg ./Binaries https://21-117715326-gh.circle-artifacts.com/0/root/project/Binaries/NWNX-EE.zip 
* Creates a builder image that downloads the NWNX bineries for the specified version and unpacks them
* Creates the main image from the Beamdog dedicated server base image
* Copies the unpacked NWNX files from the builder image
* Copies the required start script to enable copying of custom NWNX Libraries into the container
* Sets environment variables and permissions
* Sets the startup command

Example

##### Build with NWNX CI / CD NWNX binaries
* Using provided shell script to build image
	`./scripts/build-nwnx-image.sh -v 8159 -z https://21-117715326-gh.circle-artifacts.com/0/root/project/Binaries/NWNX-EE.zip`
* Using command line docker build
	`docker build -t nwnx/nwserver:8159 --build-arg NWN_VERSION=8159 --build-arg NWNX_ZIP=https://21-117715326-gh.circle-artifacts.com/0/root/project/Binaries/NWNX-EE.zip . -f Dockerfile.nwnx`

##### Docker Build for NWNX Java image

The Docker Build starts from the Base NWNX server image built in the Multi-Stage build above which is a pre-requisite for this build.

* Pass arguments to specify the following:
	* NWN_VERSION - Head start version
	* -j option to indicate  
* Creates the main image from the NWNX dedicated server base image
* Installs the JDK image

Example

##### Build from nwnx/nwserver image
* Using provided shell script to build image
	`./scripts/build-nwnx-image.sh -v 8159 -j`
* Using command line docker build
	`docker build -t nwnx/nwserver:8159.java --build-arg NWN_VERSION=8159 -j . -f Dockerfile.nwnx.java`

