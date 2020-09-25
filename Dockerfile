# new image
ADD file:603693e48cdc7f0c5c62119923aadbb266e5df5a5002fc0f61295858f91690e8 in /
RUN rm -rf /var/lib/apt/lists/*
RUN set -xe && \
	echo '#!/bin/sh' > /usr/sbin/policy-rc.d && \
	echo 'exit 101' >> /usr/sbin/policy-rc.d && \
	chmod +x /usr/sbin/policy-rc.d && \
	dpkg-divert --local --rename --add /sbin/initctl && \
	cp -a /usr/sbin/policy-rc.d /sbin/initctl && \
	sed -i 's/^exit.*/exit 0/' /sbin/initctl && \
	echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup && \
	echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean && \
	echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean && \
	echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean && \
	echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/docker-no-languages && \
	echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes && \
	echo 'Apt::AutoRemove::SuggestsImportant "false";' > /etc/apt/apt.conf.d/docker-autoremove-suggests
RUN mkdir -p /run/systemd && \
	echo 'docker' > /run/systemd/container
CMD ["/bin/bash"]
RUN apt-get update && \
	apt-get install -q -y     dirmngr     gnupg2 && \
	rm -rf /var/lib/apt/lists/*
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros1-latest.list
RUN apt-get update && \
	apt-get install --no-install-recommends -y     python-rosdep     python-rosinstall     python-vcstools && \
	rm -rf /var/lib/apt/lists/*
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
RUN rosdep init && \
	rosdep update
ENV ROS_DISTRO=kinetic
RUN apt-get update && \
	apt-get install -y     ros-kinetic-ros-core=1.3.2-0* && \
	rm -rf /var/lib/apt/lists/*
COPY file:cbbaa0f5d6a276512315f5b4d7347e94a120cefbda9058ebb0d678847ff4837f in /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
RUN apt-get update && \
	apt-get install -y     ros-kinetic-ros-base=1.3.2-0* && \
	rm -rf /var/lib/apt/lists/*
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["/bin/bash","-o","pipefail","-c","apt-get","update","\u0026\u0026","apt-get","install","-y","--no-install-recommends","cmake-curses-gui","cmake-qt-gui","dbus-x11","dmz-cursor-theme","fonts-dejavu","gconf2","gnome-terminal","gosu","language-pack-en","libarmadillo-dev","libcanberra-gtk-module","libcanberra-gtk3-0","libcanberra-gtk3-module","libdbus-glib-1-2","libgflags-dev","libglew-dev","libgoogle-glog-dev","libgoogle-perftools-dev","libgsl0-dev","libmosquitto-dev","libopencv-dev","libopenni2-dev","libpcap-dev","libssh2-1-dev","locales","pulseaudio","python-flask","python-requests","python3-colcon-common-extensions","python3-pip","python3-setuptools","python3-vcstool","sudo","tmux","v4l-utils","vim","wget","\u0026\u0026","pip3","install","-U","setuptools","\u0026\u0026","rm","-rf","/var/lib/apt/lists/*"]
RUN ["/bin/bash","-o","pipefail","-c","update-locale","LANG=en_US.UTF-8","LC_MESSAGES=POSIX"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["|2","GROUP_ID=15214","USER_ID=1000","/bin/bash","-o","pipefail","-c","groupadd","--gid","$GROUP_ID","$USERNAME","\u0026\u0026","useradd","--gid","$GROUP_ID","-m","$USERNAME","\u0026\u0026","echo","$USERNAME:$USERNAME","|","chpasswd","\u0026\u0026","usermod","--shell","/bin/bash","$USERNAME","\u0026\u0026","usermod","-aG","sudo","$USERNAME","\u0026\u0026","usermod","--uid","$USER_ID","$USERNAME","\u0026\u0026","echo","$USERNAME ALL=(ALL) NOPASSWD:ALL","\u003e\u003e","/etc/sudoers.d/$USERNAME","\u0026\u0026","chmod","0440","/etc/sudoers.d/$USERNAME"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["|2","GROUP_ID=15214","USER_ID=1000","/bin/bash","-o","pipefail","-c","echo","source /opt/ros/$ROS_DISTRO/setup.bash","\u003e\u003e","/etc/profile.d/ros.sh","\u0026\u0026","echo","export QT_X11_NO_MITSHM=1","\u003e\u003e","/etc/profile.d/autoware.sh","\u0026\u0026","echo","export LANG=\"en_US.UTF-8\"","\u003e\u003e","/etc/profile.d/autoware.sh"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["|2","GROUP_ID=15214","USER_ID=1000","/bin/bash","-o","pipefail","-c","apt-get","update","\u0026\u0026","sed","s/$ROS_DISTRO/$ROS_DISTRO/g","/tmp/dependencies","|","xargs","apt-get","install","-y","\u0026\u0026","rm","-rf","/var/lib/apt/lists/*"]
RUN ["|2","GROUP_ID=15214","USER_ID=1000","/bin/bash","-o","pipefail","-c","su","-c","rosdep update","autoware"]
RUN ["|2","GROUP_ID=15214","USER_ID=1000","/bin/bash","-o","pipefail","-c","su","-c","gconftool-2 --set \"/apps/gnome-terminal/profiles/Default/use_theme_background\" --type bool false","autoware","\u0026\u0026","su","-c","gconftool-2 --set \"/apps/gnome-terminal/profiles/Default/use_theme_colors\" --type bool false","autoware","\u0026\u0026","su","-c","gconftool-2 --set \"/apps/gnome-terminal/profiles/Default/background_color\" --type string \"#000000\"","autoware"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["|1","VERSION=1.12.0","/bin/bash","-o","pipefail","-c","su","-c","bash -c 'mkdir -p /home/$USERNAME/Autoware/src;            cd /home/$USERNAME/Autoware;            wget https://gitlab.com/autowarefoundation/autoware.ai/autoware/raw/$VERSION/autoware.ai.repos;            vcs import src \u003c autoware.ai.repos;            source /opt/ros/$ROS_DISTRO/setup.bash;            colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release'","$USERNAME"]
RUN ["|1","VERSION=1.12.0","/bin/bash","-o","pipefail","-c","echo","source /home/$USERNAME/Autoware/install/local_setup.bash","\u003e\u003e","/home/$USERNAME/.bashrc"]
RUN ["/bin/bash","-o","pipefail","-c"]
RUN ["/bin/bash","-o","pipefail","-c"]
FROM scratch
FROM scratch
# end of image: ci:backtoback (id:  tags: ci:backtoback)

# new image
FROM scratch
FROM scratch
# end of image: upbeat_btb:2020_04_09 (id:  tags: upbeat_btb:2020_04_09)

# new image
FROM scratch
# end of image: dreamy_btb:2020_04_13 (id:  tags: dreamy_btb:2020_04_13)

# new image
FROM scratch
# end of image: cool_btb:20200415 (id:  tags: cool_btb:20200415)
