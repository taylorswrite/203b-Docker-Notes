# 203b-Docker-Notes
Personal notes for docker. Pin and Star if you find it helpful.

Docker Image is a modified version of huazhou/ucla-biostat-203b-2024w which uses rocker/rstudio and rocker/geospactial but with added added packages for biostat212a and biostat203b.

### Docker Compose. If you want to quickly use the docker image:

1. Install docker on your machine [[Mac](https://docs.docker.com/desktop/install/mac-install/)] [[Windows](https://docs.docker.com/desktop/wsl/)].

2. Create an account on [dockerhub](https://hub.docker.com/), if you have not done so already.
See my dockerhub repositories [[taylorswrite](https://hub.docker.com/u/taylorswrite)].

3. Login to docker form terminal using the command: 
`docker login -u "username" -p "password"`

4. If you want docker to work now, move the docker-compose.yml file to your home
directory and edit the volumes to point to your local directories. The start of
the  directory is `./`, meaning its a realive directory that uses the location
of the docker-compose.yml as the starting directory. For **WSL** users, if you have a local
rstudio-server running, run `sudo rstudio-server stop` to free localport:8787.

5. Run `docker-compose up` in the directory you placed the docker-compose.yml to start the docker container and open localport:8787.

### Docker Build: Arm64 and Amd64 images. If you want to add packages:

Any packages added when running the container will be lost when the container is
removed. If the container is stopped, the changes will presist. However,
it is best to keep track of the packages you add in the container and also add them
to the appropriate txt file and rebuild the image as a new version.

**Review the docker-build.sh script before executing**  

run `bash ./Docker/docker-build.sh`. This takes about 3 hours to complete!!!

If you get an error or the build loops, ctrl-c and restart the bash script with the same imputs.
Your progress will be saved.


### What is a Dockerfile, a docker-compose file, Image, Container, Manifest, and Registry?

* A **Dockerfile** is the instruction set when building the image.

* Think of docker **image** as a snapshot of an operating system with all the
  packages and files you need to run your application. Images exist on dockerhub
  and your local machine. They are the layer that is between your original os 
  (eg. macos and windows) and the container. Build an image with using a 
  dockerfile.
  
* A **container** is a running instance of an image. You can have multiple
  containers running from the same image. They are not meant to be permanent. 
  You can stop and start containers, but they are meant to be disposable. 
  If you want to make changes to a container, you should make the changes in the 
  dockerfile/package_list.txt and rebuild the image.
  
* A **manifest** combines similar images like images eg. arm64 and amd64 into one image. This is useful for multi-architectural images. This simplifies how the image is pulled from dockerhub. You no longer have to specify the architecture. The manifest will pull the correct image for your machine.

* A **registry** is a collection of repositories. Dockerhub is a registry. You can create your own registry.

* A **docker-compose.yml** is a way to specify the volumes and ports you want to use. The image you specify will be pulled from dockerhub if not already on machine and checks your local machine with dockerhub. This is useful if you want to use a specific version of an image.

