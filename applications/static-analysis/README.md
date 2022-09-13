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
1. Setup xauth with client container
    1. Generate a MIT_MAGIC_COOKIE-1 by running on VM: `$ mcookie`
    1. Get <COOKIEHASH> hash by running on VM: `$ xauth list`
    1. Share cookie with container’s X11 server by running (on container): `$ xauth add attack/unix$DISPLAY . <COOKIEHASH>`
1. Create a user folder in the container by running: `# /root/setup_user.sh -u <USER> -H <HOME> `
# Notes

# Useful websites
