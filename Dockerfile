FROM linuxserver/sabnzbd
MAINTAINER Jamitupya
# original MAINTAINER Speedyyellow
# https://github.com/speedyyellow/docker-sabnzbd-mkvtools

ENV APTLIST="ffmpeg \
mkvtoolnix \
git \
python2-pip \
python2-dev \
build-essential \
rsync"

ENV PIPLIST="requests \
requests[security] \
requests \
requests-cache \
babelfish \
guessit \
subliminal \
stevedore \
dateutil \
qtfaststart \
"


# install main packages
RUN add-apt-repository ppa:mc3man/trusty-media && \
apt-get update -q && \
apt-get install \
$APTLIST -qy && \
pip install -U pip && \
pip install \
$PIPLIST && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# get the mp4 automator
RUN git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git /mp4automator %% chown -R abc:users /mp4automator
# get the mkvdts2ac3 script
RUN git clone https://github.com/JakeWharton/mkvdts2ac3.git /mkvdts2ac3 && chown -R abc:users /mkvdts2ac3
