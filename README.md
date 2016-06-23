# Docker wrapper for PowerDNS development
This repository gives you the ability to compile and run powerdns. It takes care of installing dependencies for you and supports different configurations. It builds one image per backend configuration based on the same base-image containing the general dependencies. Furthermore images are created for each individual backend e.g. MySQL database. There is also a mode for running the API-Tests. Regression-Tests will be added in the future.

## Prerequisites
* Console supporting bash
* docker
* docker-compose (version 1.6.0+)
* docker-engine (version 1.10.0+)

## Workflow

*When first starting the program, it asks you for the location of the pdns-repository.*

*More information about the 'type' and 'backend' parameters can be found [at the bottom](#parameters).*

*The script has to be executed by a user contained in the 'docker' group. By default it's only root, so you would need to run it with sudo. More information can be found [here](http://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo).*

#### 1. Init
```
./pdns_dev init
```
Removes all server images (backend images are kept) and initializes the base image for the server and api-tests.

#### 2. Configure
```
./pdns_dev configure {type} [backend]
```
Initalizes the docker image for the selected type and backend. 'configure' runs the commands specified by the commands-file of the selected backend (if existing). Afterwards it executes 'bootstrap' and 'configure' for the pdns source. The command may also be used to perform a clean build.

#### 3. Make
```
./pdns_dev make {type} [backend]
```
Compiles the pdns source by calling 'make' and 'make install'. Furthermore it copies the current .conf-files to the image. Because this commands commits the changes to the respective docker image, make sure to occasionally perform a clean build with 'configure', so the image history doesn't become bloated and thereby slow.

#### 4. Run
```
./pdns_dev run {type} [backend]
```
Run the compiled pdns. When running for the first time, you have to wait for the backend to initalize and become available, be patient ;). This command uses docker-compose and optionally sets the environment variables given by the 'environment' file for the backend. If `type=test` this runs the api-tests. The server will be accessible on port 5300. You can change the port by editing the template file located at data/internal/compose/.

#### 5. Terminal (Optional)
```
./pdns_dev terminal
```
Opens a terminal in the running pdns container. You can use this e.g. to run the pdns_util.

## Parameters <a name="parameters"></a>
#### type
This parameter either can be `server` or `test`.

`server` is used if you want to compile and run the server.

`test` is used if you want to compile an image running the api-tests.

#### backend
This parameter is only available to type `server`. If it's omitted `gmysql` is used by default.

Currently these backends are available: 
* `gmysql` : Generic MySQL
* `gpgsql` : Generic PostgreSQL

New backends can be added by following the instructions given below.

## Backends
Backends are located at data/backends/

To add a backend create a new subdirectory and name it exactly as the backend is named in pdns e.g. the name you would write in `--with-modules=` when executing `configure` from pdns. The folder structure is as follows:

```
backend_name
+-- build
|   +-- Dockerfile
|   +-- other files needed e.g. *.sql
+-- conf
|   +-- *.conf
+-- commands (optional)
+-- environment (optional)
```

File `Dockerfile` contains the docker commands to build the image. All other files needed may also be placed in `build`.

Directory `conf` contains all configuration files needed to configure the backend. (Those will be copied during `make`)

File `commands` is optional and contains the commands (seperated by ';') to be executed when the image is initalized. (e.g. apt-get update; apt-get install ...)

File `environment` is optional and contains the environment variables to be set when running the image. (Format see [here](https://docs.docker.com/compose/compose-file/#env-file))




