FROM ubuntu:focal
MAINTAINER <tec@happyn.cn>

ENV TZ=Asia/Shanghai
RUN apt update && apt install tzdata -y && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY bin/docker/happynet /usr/bin/
CMD ["/usr/bin/happynet", "-z1", "-f"]
