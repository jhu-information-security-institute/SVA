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
    $ sudo docker build -t tstatic-analysis . --no-cache
    $ sudo docker run -d --name static-analysis --privileged -e DISPLAY=$DISPLAY --security-opt seccomp=unconfined --cgroup-parent=docker.slice --cgroupns private --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -v /etc/shadow:/etc/shadow:ro -v /home/$USER/.Xauthority:/home/$USER/.Xauthority:rw --network host tstatic-analysis:latest
    $ sudo docker exec -it static-analysis bash 
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
1. Install Understand and dependencies in the running container (some dependencies are installed by the veles sequence above):
    ```
    $ wget https://s3.amazonaws.com/builds.scitools.com/all_builds/b1202/Understand/Understand-6.5.1202-Linux-64bit.tgz
    $ tar -xzvf Understand-6.5.1202-Linux-64bit.tgz
    # Install dependencies
    $ wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
    $ sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
    $ sudo apt-get install libnss3 libasound2t64 libxkbfile1 '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev libxcomposite-dev libxdamage-dev libxrandr-dev libxtst-dev libxkbfile-dev libegl-dev
    # Understand official installation instruction: https://support.scitools.com/support/solutions/articles/70000583175-installing-on-linux
    ```
1. Generate the claim code for Understand via their webpage and enter that license code into the tool using menu option at `Help->Licensing`

# Notes
* Setup xauth with client container
    * Generate a MIT_MAGIC_COOKIE-1 by running on VM: `$ mcookie`
    * Get <COOKIEHASH> hash by running on VM: `$ xauth list`
    * Share cookie with container’s X11 server by running (on container): `$ xauth add static-analysis/unix$DISPLAY . <COOKIEHASH>`

# Useful websites
