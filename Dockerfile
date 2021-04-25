FROM ubuntu

MAINTAINER john <john.kolahdouzan@gmail.com>

RUN apt-get update

CMD ["echo", "Dockerfile last line"]