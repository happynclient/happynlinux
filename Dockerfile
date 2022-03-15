FROM centos:7
MAINTAINER <tec@happyn.cn>

COPY bin/x86/happynet /usr/bin/
CMD ["/usr/bin/happynet",  "-f"]
