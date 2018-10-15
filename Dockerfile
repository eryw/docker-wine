FROM debian:stretch

# Install
RUN dpkg --add-architecture i386 && \
	sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list && \
	apt update && \
	DEBIAN_FRONTEND='noninteractive' apt install -y --no-install-recommends ca-certificates && \
	DEBIAN_FRONTEND='noninteractive' apt install -y --no-install-recommends  \
		wine-development \
		wine32-development \
		wine64-development \
		libwine-development \
		libwine-development:i386 \
		fonts-wine \
		winetricks \
		ttf-mscorefonts-installer \
		&& \
	useradd -m -s /bin/bash wine && \
	apt clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*