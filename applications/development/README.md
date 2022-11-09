# Application overview
* development container

# Runtime environment setup
1. Download files to build container
    ```
    $ wget https://raw.githubusercontent.com/jhu-information-security-institute/SVA/master/applications/development/development-KaliX86-64.sh
    $ chmod +x development-KaliX86-64.sh
    $ ./development-KaliX86-64.sh
    ```
1. Build, run, attach to container
    ```
    $ docker build -t tdevelopment .
    $ docker run -d --name development --privileged -e DISPLAY=$DISPLAY --security-opt seccomp=unconfined --cgroup-parent=docker.slice --cgroupns private --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -v /etc/shadow:/etc/shadow:ro -v /home/$USER/.Xauthority:/home/$USER/.Xauthority:rw --network host tdevelopment:latest
    $ docker exec -it development bash 
    ```
1. Create a user folder in the container by running: `# /root/setup_user.sh -u <USER> -H <HOME> `
1. `# su kali`
1. `$ cd /home/kali`
1. Download Eclipse CDT (C/C++ IDE) for 64-bit Linux in your container using - `$ wget https://download.eclipse.org/technology/epp/downloads/release/2022-12/M2/eclipse-cpp-2022-12-M2-linux-gtk-x86_64.tar.gz`
1. Download Oracle Java SE development kit (i.e., Oracle jdk) for 64-bit Linux (linux compressed archive version) into your container using - `$ wget https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz`
1. Download Ghidra into your container using - `$ wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.1.5_build/ghidra_10.1.5_PUBLIC_20220726.zip`
1. Extract eclipse - `$ tar -xzvf eclipse-cpp-2022-09-R-linux-gtk-x86_64.tar.gz`
1. `$ cd /usr/java`
1. Extract java - `$ sudo tar -xvf /home/kali/jdk-18_linux-x64_bin.tar.gz`
1. `$ cd /home/kali/ghidra`
1. Extract ghidra - `$ unzip /home/kali/ghidra_10.1.5_PUBLIC_20220726.zip`
1. Edit your ~/.bashrc by adding the following lines
    ```
    export JAVA_HOME="/usr/java/jdk-18.0.2.1"
    export SWT_GTK3=0
    alias eclipse="/home/kali/eclipse/eclipse -vm $JAVA_HOME/bin/java &"
    PATH=$PATH:$JAVA_HOME/bin
    alias ghidra="/home/kali/ghidra/ghidra_10.1.5_PUBLIC/ghidraRun"
    ```
1. Source the new `~/.bashrc` using - `$ source ~/.bashrc`
1. Eclipse may be started via - `$ eclipse`
1. Ghidra may be started via - `$ ghidra`
    * When you run ghidra the first time, point it to the $JAVA_HOME folder
# Notes
1. Setup xauth with client container
    1. Generate a MIT_MAGIC_COOKIE-1 by running on VM: `$ mcookie`
    1. Get <COOKIEHASH> hash by running on VM: `$ xauth list`
    1. Share cookie with container’s X11 server by running (on container): `$ xauth add development/unix$DISPLAY . <COOKIEHASH>`
# Useful websites
