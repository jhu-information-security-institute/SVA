# Description:
#   This runtime environment example Dockerfile creates a container for static analysis.  It
#   can run X11 applications from within the container.
# Usage:
#   From this directory, run $ docker build -t tstatic-analysis .
#   By default, runs as root
# https://docs.docker.com/network/macvlan
# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker

FROM kalilinux/kali-last-release:latest

#https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d
ENV TZ=US/Eastern
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#avoid question/dialog during apt-get installs
ARG DEBIAN_FRONTEND noninteractive

#add neccessary apt repository
RUN apt install gnupg wget -y
RUN wget -qO - https://ose-repo.syslog-ng.com/apt/syslog-ng-ose-pub.asc | apt-key add -
RUN echo "deb https://ose-repo.syslog-ng.com/apt/ stable ubuntu-noble" | tee -a /etc/apt/sources.list.d/syslog-ng-ose.list
RUN apt update

RUN apt install xauth -y

#install utilities
RUN apt install apt-utils dialog dpkg-dev debconf debconf-utils -y
RUN apt install zsh vim acl sudo wget file locate -y

#install dependencies for systemd and syslog
RUN apt install systemd systemd-sysv syslog-ng syslog-ng-core syslog-ng-mod-sql syslog-ng-mod-mongodb -y

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
RUN mkdir -p $HOME
COPY setup_user.sh /root/setup_user.sh

#For convenience, replicate /etc/sudoers.d on VM to this container \n\ 
#First remove the default one from the container
RUN rm -R /etc/sudoers.d
#Then replicate from host
VOLUME "/etc/sudoers.d"

# Finished!
RUN echo $'\n\
* For X11 forwarding to work via /tmp/.X11-unix, mount same folder and /home/$USER/.Xauthority as rw volumes and also use --network host \n\
* For convenience, bind mount (ro) /etc/group, /etc/passwd, /etc/shadow on VM to this container \n\ 
* Container is ready, run it using $ docker run -d --name static-analysis --privileged -e DISPLAY=$DISPLAY --security-opt seccomp=unconfined --cgroup-parent=docker.slice --cgroupns private --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -v /etc/shadow:/etc/shadow:ro -v /home/$USER/.Xauthority:/home/$USER/.Xauthority:rw --network host tstatic-analysis:latest \n\
* Attach to it using $ docker exec -it static-analysis bash \n\
* Finish setup of your <USER> by running # /root/setup_user.sh -u <USER> -H <HOME> \n\
* su to your user'
