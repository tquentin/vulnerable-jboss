#!/bin/bash

export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends wget openjdk-6-jre openjdk-6-jdk unzip

useradd -m -d /usr/local/jboss -s /bin/sh jboss

if [[ $1 == "4" ]]; then
    wget -O ~/jboss.zip https://sourceforge.net/projects/jboss/files/JBoss/JBoss-4.0.0/jboss-4.0.0.zip/download
    version='jboss-4.0.0'
fi

if [[ $1 == "5" ]]; then
    wget -O ~/jboss.zip https://sourceforge.net/projects/jboss/files/JBoss/JBoss-5.1.0.GA/jboss-5.1.0.GA.zip/download
    version='jboss-5.1.0.GA'
fi

if [[ $1 == "6" ]]; then
    wget -O ~/jboss.zip http://sourceforge.net/projects/jboss/files/JBoss/JBoss-6.0.0.Final/jboss-as-distribution-6.0.0.Final.zip/download
    version='jboss-6.0.0.Final'
fi

unzip ~/jboss.zip -d /usr/local
rm -rf /usr/local/jboss
chown -R jboss:jboss /usr/local/$version
ln -s /usr/local/$version/ /usr/local/jboss

cp /usr/local/jboss/bin/jboss_init_redhat.sh /usr/local/jboss/bin/jboss_init_ubuntu.sh
sed -i -e 's/\/usr\/local\/jdk\/bin/\/usr\/bin\//g' /usr/local/jboss/bin/jboss_init_ubuntu.sh

if [[ $version == 'jboss-4.0.0' ]]; then
    sed -e '67d;72d' /usr/local/jboss/server/default/deploy/jbossweb-tomcat50.sar/server.xml
fi

if [[ $version == 'jboss-5.0.0.GA' ]] || [[ $version == 'jboss-6.0.0.Final' ]]; then
    sed -i '80d;85d' /usr/local/jboss/server/default/deploy/jbossweb.sar/server.xml
fi

chmod +x /usr/local/jboss/bin/jboss_init_ubuntu.sh
chmod +x /usr/local/jboss/bin/run.sh
/usr/local/jboss/bin/jboss_init_ubuntu.sh start