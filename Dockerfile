# Copyright (c) 2016 Mattermost, Inc. All Rights Reserved.
# See License.txt for license information.
FROM dairyd/mysql:5.7

ENV REFRESHED_AT 2018-07-01

# Install ca-certificates to support TLS of Mattermost v3.5
RUN apt-get update && apt-get install -y ca-certificates

#
# Configure SQL
#

ENV MYSQL_ROOT_PASSWORD=h4bfSE4YvxFRvVZ2PrbHUD8DWFfJKG
ENV MYSQL_USER=matter
ENV MYSQL_PASSWORD=h4bfSE4YvxFRvVZ2PrbHUD8DWFfJKG
ENV MYSQL_DATABASE=mm4

#
# Configure Mattermost
#
WORKDIR /opt

# Copy over files
ADD https://releases.mattermost.com/5.0.0-rc1/mattermost-team-5.0.0-rc1-linux-amd64.tar.gz .
RUN tar -zxvf ./mattermost-team-5.0.0-rc1-linux-amd64.tar.gz
ADD config_docker.json ./mattermost/config/config_docker.json
ADD docker-entry.sh .

RUN chmod +x ./docker-entry.sh
ENTRYPOINT ./docker-entry.sh

# Create default storage directory
RUN mkdir ./mattermost-data
VOLUME ./mattermost-data

# Ports
EXPOSE 8065
