# Application overview
* static analysis container

# Runtime environment setup
1. Download files to build container
    ```
    $ wget https://raw.githubusercontent.com/jhu-information-security-institute/SVA/master/applications/static-analysis/static-analysis-KaliX86-64.sh
    $ chmod +x static-analysis-KaliX86-64.sh
    $ ./static-analysis-KaliX86-64.sh
    ```
1. Build, run, attach to container
    ```
    $ docker build -t tstatic-analysis .
    $ docker run -d --name static-analysis --privileged -e DISPLAY=$DISPLAY --security-opt seccomp=unconfined --cgroup-parent=docker.slice --cgroupns private --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -v /etc/shadow:/etc/shadow:ro -v /home/$USER/.Xauthority:/home/$USER/.Xauthority:rw --network host tstatic-analysis:latest
    $ docker exec -it static-analysis bash 
    ```
1. Create a user folder in the container by running: `# /root/setup_user.sh -u <USER> -H <HOME> `
1. Run the container and setup the kali user using: `# /root/setup_user.sh -u kali -H /home/kali`
1. switch to the kali user using: `# su kali`
1. change to the kali user home directory using: `$ cd`
1. Install Veles and dependencies in the running container (last command will address missing dependency errors):
    ```
    $ wget https://github.com/codilime/veles/releases/download/2018.05.0.TIF/Veles_2018.05_64bit_Ubuntu1604.deb
    $ sudo dpkg -i Veles_2018.05_64bit_Ubuntu1604.deb
    $ sudo apt install -f
    ```
1. Download the understand installer from their website into your VM
1. Copy Understand installer to the running container using: `$ docker cp ~/Downloads/Understand-6.2.1118-Linux-64bit.tgz static-analysis:/home/kali/.`
1. Install Understand and dependencies in the running container (some dependencies are installed by the veles sequence above):
    ```
    $ tar -xzvf Understand-6.2.1118-Linux-64bit.tgz
    $ sudo apt-get install libnss3 libasound2 libxkbfile1 libssl1.1
    ```
1. Generate the claim code for Understand via their webpage and enter that license code into the tool using menu option at `Help->Licensing`

# Notes
* Setup xauth with client container
    * Generate a MIT_MAGIC_COOKIE-1 by running on VM: `$ mcookie`
    * Get <COOKIEHASH> hash by running on VM: `$ xauth list`
    * Share cookie with container’s X11 server by running (on container): `$ xauth add attack/unix$DISPLAY . <COOKIEHASH>`
   
# Useful websites
