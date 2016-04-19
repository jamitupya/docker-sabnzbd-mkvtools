FROM linuxserver/sabnzbd
MAINTAINER Jamitupya
# original MAINTAINER Speedyyellow
# https://github.com/speedyyellow/docker-sabnzbd-mkvtools

ENV APTLIST="ffmpeg \
mkvtoolnix \
git \
python-pip \
python-dev \
build-essential \
rsync"

# install main packages
RUN add-apt-repository ppa:mc3man/trusty-media && \
apt-get update -q && \
apt-get install \
$APTLIST -qy

# install pip and prerequisites
RUN git clone https://github.com/jamitupya/docker-sabnzbd-mkvtools /dockerfile && cd /dockerfile && git checkout mp4automator && git fetch
RUN pip install --upgrade pip && cd /dockerfile && pip install -r pip.req

# cleanup
RUN apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# get the mp4 automator
RUN git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git /mp4automator && chown -R abc:users /mp4automator && chmod 755 /mp4automator/info.log

# get the mkvdts2ac3 script
RUN git clone https://github.com/JakeWharton/mkvdts2ac3.git /mkvdts2ac3 && chown -R abc:users /mkvdts2ac3

