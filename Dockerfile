
FROM openshift/base-centos7

# Builder version
ENV BUILDER_VERSION 1.0

# Install required util packages
RUN yum -y update; \
    yum install tar -y; \
    yum install unzip -y; \
    yum install ca-certificates -y; \
    yum install sudo -y; \
    yum clean all -y


# Install OpenJDK 1.8, Maven create required directories.
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel maven && \
    yum clean all -y && \
    mkdir -p /opt/openshift

COPY target/bookstore-*.jar  /opt/openshift/bookstore.jar

#Set entry point for Spring Boot application
ENTRYPOINT ["java","-jar","/opt/openshift/bookstore.jar"]

# Set the default port for applications built using this image
EXPOSE 8080