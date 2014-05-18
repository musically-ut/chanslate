# Install Chanslate in a container

FROM ubuntu:14.04
MAINTAINER Utkarsh Upadhyay "mail@musicallyut.in"
WORKDIR /data/chanslate

# Install dependencies for installation
RUN apt-get update
RUN apt-get install -y git curl software-properties-common python-software-properties python g++ make --force-yes

# Install Node & npm
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get -y install nodejs --force-yes

# Create a new user with a home folder to run the following commands
RUN useradd -m -d /home/chanslate chanslate
RUN chown    chanslate /data/chanslate 
RUN chgrp -R chanslate /data/chanslate 
RUN chmod g+s          /data/chanslate

# Now act as that user
USER chanslate
# Docker does not set the user home dir by default (#2968)
ENV HOME /home/chanslate 

# Install meteor and meteorite (only locally, sans sudo access)
RUN echo "prefix = ~/.node" >> ~/.npmrc  
RUN curl https://install.meteor.com/ | sh
RUN npm install -g meteorite meteor-npm forever

# Fetch and install the dependencies of Chanslate
RUN git clone https://github.com/musically-ut/chanslate.git chanslate-src
RUN cd /data/chanslate/chanslate-src  && ~/.node/bin/mrt install

# Bundle the app and prepare for launch
RUN mkdir -p /data/chanslate/dist/
RUN cd /data/chanslate/chanslate-src/ && ~/.meteor/meteor bundle /data/chanslate/dist/chanslate.tar.gz
RUN cd /data/chanslate/dist/          && tar xvf chanslate.tar.gz

# The Meteor App should run on port 3000 and binds to 0.0.0.0 so that host can connect to it
ENV BIND_IP 0.0.0.0
ENV PORT 3000
CMD ~/.node/bin/forever dist/bundle/main.js
