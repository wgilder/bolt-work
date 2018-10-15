FROM centos:7

MAINTAINER Walter Gildersleeve "wmg@puppet.com"

RUN rpm -Uvh https://yum.puppet.com/puppet6/puppet6-release-el-7.noarch.rpm
RUN yum install puppet-bolt -y

ENTRYPOINT [ "bolt" ]
CMD [ "--help" ]
