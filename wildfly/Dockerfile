FROM jboss/wildfly:latest

MAINTAINER Reza Alemy <reza@alemy.net>


# MySql Database
ENV DB_DS   argus
ENV DB_NAME guard
ENV DB_USER sa
ENV DB_PASSWORD sa
ENV DB_URI db:3306
ENV MYSQL_VERSION 8.0.12

# Jboss Wildfly
ENV WILDFLY       /opt/jboss/wildfly
ENV STANDALONE    $WILDFLY/standalone
ENV JBOSS         $WILDFLY/bin/jboss-cli.sh
ENV DEPLOYMENTS   $STANDALONE/deployments
ENV MODULES       $WILDFLY/modules
ENV W_USER jboss
ENV W_PASS jboss

# ActiveMQ
ENV AMQ_VERSION   5.10.0
ENV AMQ_DIRECTORY $MODULES/org/apache/activemq/main
ENV AMQ_USER admin
ENV AMQ_PASSWORD adminactivemq
ENV AMQ_QUEUE  DEFAULTQueue
ENV AMQ_TOPIC  DEFAULTTopic
ENV AMQ_URL tcp://argus-activemq:61616

USER root

RUN yum install -y wget
RUN wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
RUN rpm -ivh mysql57-community-release-el7-9.noarch.rpm
RUN yum install -y mysql-server

# bring in external files
ADD config  /opt
ADD jars    /opt

RUN chmod a+rwx /opt/*.sh
RUN sed -i 's@[<]resolve-parameter-values[>]\s*false\s*[<][/]resolve-parameter-values[>]@<resolve-parameter-values>true</resolve-parameter-values>@i' $WILDFLY/bin/jboss-cli.xml

# add MySQL and ActiveMQ modules
RUN echo "mysql" >> /opt/jboss/argus.db
RUN /opt/runJbossBatch.sh step1.batch

# adding ActiveMQ jar files
RUN unzip /opt/activemq-rar-5.10.0.rar -d $AMQ_DIRECTORY
RUN rm -f $AMQ_DIRECTORY/broker-config.xml
RUN rm -f $AMQ_DIRECTORY/log4j*
RUN rm -f $AMQ_DIRECTORY/slf4j*
RUN rm -f $AMQ_DIRECTORY/geronimo*

RUN cp /opt/wfly.jks $STANDALONE/configuration
RUN /opt/runJbossBatch.sh step2.batch

ADD argus.ear $DEPLOYMENTS

RUN sed -i 's@[<][/]paths[>]@<path name="com/sun/management" /> \n<path name="com/sun/org/apache/xerces/internal/dom" />\n</paths>@i' $WILDFLY/modules/system/layers/base/sun/jdk/main/module.xml
#switch to jboss user
RUN $WILDFLY/bin/add-user.sh jboss jboss
RUN chown -R jboss:jboss $WILDFLY/*

USER jboss


EXPOSE 8080 9990 8443 4488

CMD ["/opt/wait-for-mysql.sh"]
