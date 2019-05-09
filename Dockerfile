FROM debian:stretch

# Install
RUN dpkg --add-architecture i386 && \
	apt update && \
	DEBIAN_FRONTEND='noninteractive' apt install -y --no-install-recommends ca-certificates gnupg2 wget && \
	wget -O- https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
	apt purge -y gnupg2 wget && \
	apt autoremove -y && \
	sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list && \
	echo "\ndeb http://dl.winehq.org/wine-builds/debian/ stretch main\n" >> /etc/apt/sources.list && \
	apt update && \
	DEBIAN_FRONTEND='noninteractive' apt install -y --no-install-recommends  \
		winehq-devel \
		fonts-wine \
		winetricks \
		ttf-mscorefonts-installer \
		&& \
	useradd -m -s /bin/bash wine && \
	apt clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*