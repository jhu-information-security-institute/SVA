# Description:
#   This runtime environment example Dockerfile creates a container for development.  It
#   can run X11 applications from within the container.
# Usage:
#   From this directory, run $ docker build --build-arg USER=<USER> -t tdevelopment .
#   By default, runs as root
# https://docs.docker.com/network/macvlan
# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker

FROM kalilinux/kali-last-release:latest

ARG USER

#https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d
ENV TZ=US/Eastern
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#avoid question/dialog during apt-get installs
ARG DEBIAN_FRONTEND noninteractive

#update
RUN apt update
RUN apt install gnupg wget -y
RUN wget -qO - https://ose-repo.syslog-ng.com/apt/syslog-ng-ose-pub.asc | apt-key add -
RUN echo "deb https://ose-repo.syslog-ng.com/apt/ stable ubuntu-noble" | tee -a /etc/apt/sources.list.d/syslog-ng-ose.list
RUN apt update

RUN apt-get install xauth -y

#install utilities
RUN apt-get install apt-utils dialog dpkg-dev debconf debconf-utils -y
RUN apt-get install zsh vim acl sudo wget file locate unzip procps -y

#install development stuff
RUN apt-get install git build-essential binutils gcc-multilib g++-multilib gdb-multiarch nasm checksec cowsay -y

#install eclipse dependencies
RUN apt-get install libswt-gtk-4-java libswt-gtk-4-jni -y

#install ghidra dependencies
RUN apt-get install libxrender1 libxtst6 libxi6

#install dependencies for systemd and syslog
RUN apt-get install systemd systemd-sysv syslog-ng syslog-ng-core syslog-ng-mod-sql syslog-ng-mod-mongodb dbus-x11 -y

VOLUME [ "/tmp", "/run", "/run/lock" ]
# Remove unnecessary units
RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
  /etc/systemd/system/*.wants/* \
  /lib/systemd/system/local-fs.target.wants/* \
  /lib/systemd/system/sockets.target.wants/*udev* \
  /lib/systemd/system/sockets.target.wants/*initctl* \
  /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
  /lib/systemd/system/systemd-update-utmp*
CMD [ "/lib/systemd/systemd", "log-level=info", "unit=sysinit.target" ]

#Must create a directory for any host VM users you intend to also use in the container
RUN mkdir -p /home/$USER
RUN mkdir -p /usr/java
RUN mkdir -p /home/$USER/ghidra
RUN mkdir -p /home/$USER/sandbox
COPY setup_user.sh /root/setup_user.sh
RUN chmod +x /root/setup_user.sh

#For convenience, replicate /etc/sudoers.d on VM to this container \n\ 
#First remove the default one from the container
RUN rm -R /etc/sudoers.d
#Then replicate from host
VOLUME "/etc/sudoers.d"

SHELL ["/bin/bash", "-ec"]

# Finished!
RUN echo $'\n\
* For X11 forwarding to work via /tmp/.X11-unix, mount same folder and /home/$USER/.Xauthority as rw volumes and also use --network host \n\
* For convenience, bind mount (ro) /etc/group, /etc/passwd, /etc/shadow on VM to this container \n\ 
* Container is ready, run it using $ docker run --ipc=host -d --name development --privileged -e DISPLAY=$DISPLAY --security-opt seccomp=unconfined --cgroup-parent=docker.slice --cgroupns private --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v /etc/group:/etc/group:rw -v /etc/passwd:/etc/passwd:rw -v /etc/shadow:/etc/shadow:rw -v /home/$USER/.Xauthority:/home/$USER/.Xauthority:rw -v /home/$USER/sandbox:/home/$USER/sandbox:rw --network host tdevelopment:latest \n\
* Attach to it using $ docker exec -it development bash \n\
* Finish setup of your <USER> by running # /root/setup_user.sh -u <USER> -H <HOME> \n\
* su to your user'
