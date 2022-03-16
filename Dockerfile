FROM centos:7
MAINTAINER <tec@happyn.cn>

COPY bin/x64/happynet /usr/bin/
CMD ["/usr/bin/happynet", "-z1", "-f"]
