FROM ubuntu:24.04
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get autoremove -y \
 && apt-get autoclean -y \
 && apt-get install -y \
 sudo \
 nano \
 wget \
 curl \
 git \
 build-essential \
 gcc \
 openjdk-21-jdk \
 mono-complete \
 python3 \
 strace \
 valgrind
RUN useradd -G sudo -m -d /home/Vetle -s /bin/bash -p "$(openssl passwd -1 12345)" Vetle
USER Vetle
WORKDIR /home/Vetle
RUN mkdir hacking \
 && cd hacking \
 && curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
 && chmod 764 pawned.sh \
 && cd ..
RUN git config --global user.email "vetlemol@gmail.com" \ 
 && git config --global user.name "vetlemol" \
 && git config --global url."https://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:@github.com/".insteadOf "https://github.com" \
 && mkdir -p github.com/vetlemol
USER root
ARG DEBIAN_FRONTEND=noninteractive
RUN curl -SL https://go.dev/dl/go1.22.2.darwin-amd64.tar.gz \
 | tar xvz -C /usr/local
USER Vetle
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/Vetle/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf \ 
 | sh -s -- -y
ENV PATH="${PATH}:${HOME}/.cargo/bin"
