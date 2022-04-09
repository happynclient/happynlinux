FROM ubuntu:focal
MAINTAINER <tec@happyn.cn>

ENV TZ=Asia/Shanghai
RUN apt install tzdata -y && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY bin/x64/happynet /usr/bin/
CMD ["/usr/bin/happynet", "-z1", "-f"]
