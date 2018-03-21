# Using Docker

**Intended audience: Server Administrators**

This document covers running nwserver in docker containers.

* Note to Windows users: At the time of writing there are no Windows images for nwserver and NWNX:EE does not have 100% Windows support yet. Consequently, running nwserver in a docker container is limited to Linux. The software used to run Linux containers on Windows depends on the presence of Hyper-V support, a gated feature only available on Windows Professional and above. For Windows Home users the replacement for Hyper-V is Virtual Machines, and the program [DockerToolbox](https://docs.docker.com/toolbox/overview/) handles this very well by utilizing VirtualBox.*
* Note to OSX users: Docker provides a native installation for MacOS so the commands below will work on MacOS.*

## What is Docker and what are Containers?

### What is Docker?

Docker is an OpenSource tool that is used to create, deploy, and run applications as containers. Containers allow the packaging 
of an application and its dependencies, libraries and bineries as one package. This ensures the application will run on any machine 
that supports and runs Docker.

A Docker container is similar to a virtual machine. Unlike a virtual machine, which creates an entire virtual operating system, 
Docker allows containers to use the same kernel as the system that they're running on.  Containers are only packaged with 
libraries and bineries not already running on the host computer. This gives a significant performance boost and reduces the size of the application.

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

### Why Contianers and not Virtual Machines?

Virtual Machines have been around longer and can provide a similar "Build and image once and run anywhere" experience. Containers however can offer 
several advantages:

* Containers are smaller than Virtual Machines - containers only include the minimum requirements needed to run an application
* Containers have less overhead - since containers 'share' the host OS services they have better performance on a per application basis
* Containers have better host CPU and memory utilization - containers don't contain a full instance of the OS, are very lightweight and less overhead than virtual machines.


## Dependencies

* docker [Reference](https://docs.docker.com/edge/engine/reference/commandline/docker/)
    * Windows 10 Pro - Install Docker CE https://docs.docker.com/docker-for-windows/install/
    * Windows 7, Windows 8, Windows 10 Home - Install Docker Toolbox https://docs.docker.com/toolbox/toolbox_install_windows/
    * MacOS - Install Docker CE https://docs.docker.com/docker-for-mac/install/
    * Linux - Install Docker CE for your Linux distribution https://docs.docker.com/install/
* docker-compose [Reference](https://docs.docker.com/compose/compose-file/compose-file-v2/)
    * Docker for Windows and Docker Toobox have docker-compose included - no additional steps are required
    * Docker for Mac or Linux - Follow the steps here https://docs.docker.com/compose/install/

## Configure

Configuration is esily managed using `docker-compose`. [examples](https://gitlab.com/glorwinger/nwnx-docker-builder/tree/master/examples).

When Docker containers are started using a docker-compose.yml file they share a network and each service name is assigned an IP address 
allowing the containers to communicate using those names. To access the containers from the host ports can be mapped and exposed.  The examples below 
are set up to start the nwnserver and any other dependencies (MySQL or PostgreSQL).  NWNX can be configured and server settings can be passed to the containers.
The containers will store data on the host machine allowing persistence accross upgrades.

The examples have the following:
* [docker-compose-mysql](https://gitlab.com/glorwinger/nwnx-docker-builder/blob/master/examples/docker-compose-mysql.yml) Start nwnserver and MySQL. The nwnserver will wait for the MySQL instance to be running before starting.
* [docker-compose-postgresql](https://gitlab.com/glorwinger/nwnx-docker-builder/blob/master/examples/docker-compose-postgresql.yml)  Start nwnserver and PostgreSQL. The nwnserver will wait for the PostgreSQL instance to be running before starting.

## Run

### With docker-compose
When using docker compose it is best to have the current working direct the same folder as the docker-compose.yml file.  You can use a commandline 
option to give the path and file but if you do ensure all paths for volume mounts etc. are absolute and not relative.

1. This command will start all services listed in the compose file and run them in the background
```
docker-compose up -d
```

2. Stop all containers in the compose file
```
docker-compose stop
```

3. Remove all stopped containers in the compose file
```
docker-compose rm
```

4. Stop and Remove all containers in the compose file
```
docker-compose down
```

5. View and follow docker logs 
```
docker-compose logs -f
```

6. This command will start the named service in the compose file and run it in the background
```
docker-compose up -d <service name>
```

7. Stop the named service in the compose file
```
docker-compose stop <service name>
```

8. Remove the named service in the compose file 
```
docker-compose rm <service name>
```

9. Start a shell in the running container
```
docker exec -it (container name) /bin/bash
```

10. Attach to the running shell
```
docker attach (container name)
```
Detach safely with `ctrl+p ctrl+q`

11. List containers
```
docker ps
```

12. List stopped containers
```
docker ps -a
```

### Review docker-compose

For questions regarding the nwserver image, please refer to the [image documentation](https://hub.docker.com/r/beamdog/nwserver/).

#### Create the database container
```
docker-compose up -d db
```

#### Create the nwserver container
To function properly, the container needs access to the
- host directory containing the module resources, assumed to be located under $(pwd)/server
- database container

```
docker-compose up -d nwnserver
```


## Play

Native Docker: Direct connect to `localhost:5121`.

DockerToolbox: Because Docker runs in a Linux Virtual Machine you either have to forward the port, or connect to the VM IP (default IP is `192.168.99.100:5121`). If you want to forward the port, open VirtualBox and navigate to Settings -> Network -> Advanced -> Port Forwarding, and add UDP port 5121 (no IP necessary). You should now be able to connect to `localhost:5121`. How-to-geek has an [example with screenshots](https://www.howtogeek.com/122641/how-to-forward-ports-to-a-virtual-machine-and-use-it-as-a-server/) for your convenience.
