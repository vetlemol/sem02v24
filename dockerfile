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
 git
RUN useradd -G sudo -m -d /home/vetlemol -s /bin/bash -p "$(openssl 
passwd -1 12345)" vetlemol
USER vetlemol
WORKDIR /home/vetlemol
RUN mkdir hacking \
 && cd hacking \
 && curl -SL 
https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v2
4/pawned.sh > pawned.sh \
 && chmod 764 pawned.sh \
 && cd ..
RUN git config --global user.email "vetlemol@gmail.com"
\
 && git config --global user.name "Vetle" \
 && git config --global url."https://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:@github.com/".insteadOf 
"https://github.com" \
 && mkdir -p github.com/vetlemol
USER root
RUN curl -SL https://go.dev/dl/go1.21.7.OS-ARCH.tar.gz \
 | tar xvz -C /usr/local
USER vetlemol
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/vetlemol/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
