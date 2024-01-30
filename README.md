# 203b-Docker-Notes
Personal notes for docker. Pin and Star if you find it helpful.

Docker Image is a modified version of huazhou/ucla-biostat-203b-2024w which uses rocker/rstudio and rocker/geospactial but with added added packages for biostat212a and biostat203b.

### Docker Compose:

1. Install docker on your machine [[Mac](https://docs.docker.com/desktop/install/mac-install/)] [[Windows](https://docs.docker.com/desktop/wsl/)].

2. Create an account on [dockerhub](https://hub.docker.com/), if you have not done so already.
See my dockerhub repositories [[taylorswrite](https://hub.docker.com/u/taylorswrite)].

3. Login to docker form terminal using the command: 
`docker login -u "username" -p "password"`

4. If you want docker to work now, move the docker-compose.yml file to your home
directory and edit the volumes to point to your local directories. The start of
the  directory is `./`, meaning its a realive directory that uses the location
of the docker-compose.yml as the starting directory. For **WSL** users, if you have a local
rstudio-server running, run `sudo rstudio-server stop` to open localport:8787.

5. Run `docker-compose up` in the directory you placed the docker-compose.yml to start the docker container and open localport:8787.

### Docker Build: Arm64 and Amd64 images

If you want to BUILD your own image because you are missing a package. Add the package name to the packages txt file. 

**Review the docker-build.sh script before executing** then run `bash docker-build.sh`.
This takes about 3 hours to complete!!!

