FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install -y wget lib32gcc1 lib32tinfo5 unzip

RUN useradd -ms /bin/bash steam

WORKDIR /home/steam

USER steam

RUN wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf /tmp/steamcmd_linux.tar.gz && \
    rm /tmp/steamcmd_linux.tar.gz

# Install CS 1.6 once to speed up container startup
RUN ./steamcmd.sh +login anonymous +force_install_dir ./hlds +app_update 90 validate +quit || true
RUN ./steamcmd.sh +login anonymous +app_update 70 validate +quit || true
RUN ./steamcmd.sh +login anonymous +app_update 10 validate +quit || true
RUN ./steamcmd.sh +login anonymous +force_install_dir ./hlds +app_update 90 validate +quit

ENV CSS_HOSTNAME Counter-Strike 1.6 Dedicated Server

ADD ./entrypoint.sh entrypoint.sh
RUN ln -s /home/steam/linux32/ /home/steam/.steam/sdk32
CMD ./entrypoint.sh