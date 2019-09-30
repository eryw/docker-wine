FROM debian:buster

# Install
RUN dpkg --add-architecture i386 && \
	apt update && \
	DEBIAN_FRONTEND='noninteractive' apt install -y --no-install-recommends ca-certificates gnupg2 wget && \
	wget -O- https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
	sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list && \
	echo "\ndeb http://dl.winehq.org/wine-builds/debian/ buster main\n" >> /etc/apt/sources.list && \
	wget https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/amd64/libfaudio0_19.09-0~buster_amd64.deb && \
	wget https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/i386/libfaudio0_19.09-0~buster_i386.deb && \
	apt install -y --no-install-recommends ./*.deb && \
	apt full-upgrade -y && \
	apt update && \
	DEBIAN_FRONTEND='noninteractive' apt install -y --no-install-recommends \
		winehq-staging \
		winetricks \
		&& \
	useradd -m -s /bin/bash wine && \
	wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O /home/wine/winetricks && \
	chown wine:wine /home/wine/winetricks && \
	chmod +x /home/wine/winetricks && \
	apt autoremove -y && \
	apt clean && \
	rm -f *.deb && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

