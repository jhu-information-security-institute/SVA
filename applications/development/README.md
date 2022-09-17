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
1. Setup xauth with client container
    1. Generate a MIT_MAGIC_COOKIE-1 by running on VM: `$ mcookie`
    1. Get <COOKIEHASH> hash by running on VM: `$ xauth list`
    1. Share cookie with container’s X11 server by running (on container): `$ xauth add development/unix$DISPLAY . <COOKIEHASH>`
1. Create a user folder in the container by running: `# /root/setup_user.sh -u <USER> -H <HOME> `
# Notes
4.	Download and install Eclipse CDT (C/C++ IDE) for 64-bit Linux here
a.	$ cd /home/kali
b.	Extract eclipse - $ sudo tar -xzvf ~/Downloads/eclipse-cpp-2022-09-R-linux-gtk-x86_64.tar.gz
5.	Download and install Oracle Java SE development kit (i.e., Oracle jdk) for 64-bit Linux (linux compressed archive version) here
a.	Create a folder for java - $ sudo mkdir -p /usr/java && cd /usr/java
b.	Extract java - $ sudo tar -xvf ~/Downloads/jdk-18_linux-x64_bin.tar.gz
i.	You will need to use the appropriate name for the *.tar.gz above
c.	Edit your ~/.bashrc by adding the following lines
i.	You will need to use the appropriate names for JAVA_HOME path
export JAVA_HOME="/usr/java/jdk-18.0.2.1"
export SWT_GTK3=0
alias eclipse="/home/kali/eclipse/eclipse -vm $JAVA_HOME/bin/java &"
PATH=$PATH:$JAVA_HOME/bin
d.	Source the new ~/.bashrc - $ source ~/.bashrc
e.	Eclipse may be started via - $ eclipse
6.	Download and install Ghidra (here)
a.	Put the ghidra_9.1.2_PUBLIC_20200212.zip file in ~/Downloads
b.	Create a folder for Ghidra - $ sudo mkdir -p /opt/ghidra && cd /opt/ghidra
c.	Extract Ghidra - $ sudo unzip ~/Downloads/ghidra_9.1.2_PUBLIC_20200212.zip
d.	Edit your ~/.bashrc by adding the following line
alias ghidra="/opt/ghidra/ghidra_9.1.2_PUBLIC/ghidraRun"
e.	When you run ghidra the first time, point it to the /usr/java/jdk-15 folder

# Useful websites
