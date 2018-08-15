FROM ubuntu:12.04
LABEL maintainer="Pansaen Boonyakarn <pansaen@i-secure.co.th>"

ENV DEBIAN_FRONTEND=noninteractive

# Offline build
# ARG version
# ADD build/ /build
# ADD server/${version}.zip /server/${version}.zip
# RUN /build/build_offline.sh $version

# Online build
ARG version
ADD build/ /build
RUN /build/build_online.sh $version

EXPOSE 8080
CMD ["/usr/local/jboss/bin/run.sh", "-c", "default", "-b", "0.0.0.0"]