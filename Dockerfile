FROM ubuntu

WORKDIR /root 
RUN apt update && apt install -y make gcc automake
COPY . ./themisqlite3
WORKDIR /root/themisqlite3
RUN bash ./configure && make && run install

ENTRYPOINT /bin/bash