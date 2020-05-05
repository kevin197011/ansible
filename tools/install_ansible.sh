yum install -y epel-release
yum clean packages
yum clean headers
yum clean metadata
yum clean all

yum install -y ansible