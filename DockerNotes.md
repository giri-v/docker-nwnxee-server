# Using Docker

**Intended audience: Server Administrators**

This document covers running nwserver in docker containers.

* Note to Windows users: At the time of writing there are no Windows images for nwserver and NWNX:EE does not have 100% Windows support yet. Consequently, running nwserver in a docker container is limited to Linux. The software used to run Linux containers on Windows depends on the presence of Hyper-V support, a gated feature only available on Windows Professional and above. For Windows Home users the replacement for Hyper-V is Virtual Machines, and the program [DockerToolbox](https://docs.docker.com/toolbox/overview/) handles this very well by utilizing VirtualBox.*
* Note to OSX users: Docker provides a native installation for MacOS so the commands below will work on MacOS.*

## What is Docker and what are Containers?

### What are containers?

One way to describe the concept of Docker containers is to describe and automobile it's functions.

Your car does a few things:

* Removes you from dealing directly with the road
* Removes you from dealing directly with the weather
* Allows you to deal with the path of travel using functions inside the car (e.g., steering wheel, lights, and brakes)
* Provides features such as air conditioning and heat that keep you comfortable

In other words, your automobile is a container that provides features to guide it, and yourself, down the road. 
You don’t have to deal directly with the physical environment outside the container.  That outside environment provides a 
common set of infrastructure that any automobile can use.  Docker provides common infrastructure enabling software containers 
to run on multiple platforms.  

### Why Continaers and not Virtual Machines?

Virtual Machines have been around longer and can provide a similar "Build and image once and run anywhere" experience. Containers however can offer 
several advantages:

* Containers are smaller than Virtual Machines - containers only include the minimum requirements needed to run an application
* Containers have less overhead - since containers 'share' the host OS services they have better performance on a per application basis
* Containers have better host CPU and memory utilization - containers don't contain a full instance of the OS, are very lightweight and less overhead than virtual machines.


## Dependencies

* docker
** Windows 10 Pro - Install Docker CE https://docs.docker.com/docker-for-windows/install/
** Windows 7, Windows 8, Windows 10 Home - Install Docker Toolbox https://docs.docker.com/toolbox/toolbox_install_windows/
** MacOS - Install Docker CE https://docs.docker.com/docker-for-mac/install/
** Linux - Install Docker CE for your Linux distribution https://docs.docker.com/install/
* docker-compose (optional but highly recommended)


## Configure

Configuration is esily managed using `docker-compose`. You can find an example in [./docker-compose.yml](https://github.com/jakkn/nwn-devbase/blob/master/docker/docker-compose.yml).

## Run

### With docker-compose
```
docker-compose up -d
```
Stop (and remove all containers including volumes) with
```
docker-compose stop
```


### Without docker-compose

For questions regarding the nwserver image, please refer to the [image documentation](https://hub.docker.com/r/beamdog/nwserver/).

*Note: The db instructions are subject to change as I have not tested db connection on NWNX:EE yet.*

#### Create the database container
```
docker pull mysql:5.7
docker run \
  --name nwn-mysql \
  -v $(pwd)/docker/mysql-db:/docker-entrypoint-initdb.d \
  -e MYSQL_ROOT_PASSWORD=password \
  -d \
  mysql:5.7
```

#### Create the nwserver container
To function properly, the container needs access to the
- host directory containing the module resources, assumed to be located under $(pwd)/server
- database container

```
docker run -it \
  -v $(pwd)/server:/nwn/home \
  --link nwn-mysql:mysql \
  -p 5121:5121/udp \
  --name nwn-devbase-test \
  beamdog/nwserver:latest
```

`-v` mounts a host directory as a volume in the container. `--link nwn-mysql:mysql` creates a link between the mysql container and the nwn-devbase-test container. Note: the name following the colon - *mysql* in this case - is the name of the server, and must correspond with the database server specified in the nwnx2.ini, but this should work out of the box unless it has been changed in the Dockerfile. `-p` specifies which container ports to expose to the host system. Docker will not expose UDP by default and must be specified to enable nwserver connections.

If you need haks, overrides, or other custom files they should be placed in the *server* directory.

#### Restarting the container
From now on you should only need the following two commands to start and stop the server.
```
docker restart nwn-devbase-test
docker stop nwn-devbase-test
```

#### Claim a shell in the running server
```
docker exec -it nwn-devbase-test /bin/bash
```

#### Attach to the running shell
```
docker attach nwn-devbase-test
```
Detach safely with `ctrl+p ctrl+q`


## Play

Native Docker: Direct connect to `localhost:5121`.

DockerToolbox: Because Docker runs in a Linux Virtual Machine you either have to forward the port, or connect to the VM IP (default IP is `192.168.99.100:5121`). If you want to forward the port, open VirtualBox and navigate to Settings -> Network -> Advanced -> Port Forwarding, and add UDP port 5121 (no IP necessary). You should now be able to connect to `localhost:5121`. How-to-geek has an [example with screenshots](https://www.howtogeek.com/122641/how-to-forward-ports-to-a-virtual-machine-and-use-it-as-a-server/) for your convenience.
