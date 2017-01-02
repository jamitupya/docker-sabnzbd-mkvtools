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
ntp \
ntpdate \
rsync"

# set defaults
ENV TZN=Asia/Hong_Kong
ENV TZ=Asia/Hong_Kong
ENV PGID=0
ENV PUID=0


# install main packages
RUN add-apt-repository ppa:mc3man/trusty-media && \
apt-get update -q && \
apt-get install \
$APTLIST -qy

# setup timezone correctly
#RUN echo $TZN > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata && 
#RUN ntpdate -s ntp.ubuntu.com

# install pip and prerequisites
RUN git clone https://github.com/jamitupya/docker-sabnzbd-mkvtools /dockerfile && cd /dockerfile && git checkout mp4automator && git fetch
RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | python
RUN pip install --upgrade pip && cd /dockerfile && pip install -r pip.req

# cleanup
RUN apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# permissions for postprocess
RUN chown -R abc:users /postprocess ; chown -R abc:users /scripts 

# get the mp4 automator
RUN git clone https://github.com/mdhiggins/sickbeard_mp4_automator /mp4automator ; chown -R abc:users /mp4automator ; touch /mp4automator/info.log ; chmod -R 777 /mp4automator/

# get the mkvdts2ac3 script
RUN git clone https://github.com/JakeWharton/mkvdts2ac3.git /mkvdts2ac3 && chown -R abc:users /mkvdts2ac3

VOLUME /config /downloads /incomplete-downloads /postprocess /mp4automator /scripts
EXPOSE 8080 9090