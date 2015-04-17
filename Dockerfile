FROM jpetazzo/dind:latest
MAINTAINER Qiu Yu <unicell@gmail.com>

ENV LOG file

RUN apt-get update -q
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# fix: `stdin: is not a tty` message
RUN sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
RUN apt-get install -y build-essential

RUN curl -sSL https://golang.org/dl/go1.3.3.linux-amd64.tar.gz | tar -v -C /root -xz
ENV GOROOT /root/go
ENV GOPATH /root/gocode
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin
