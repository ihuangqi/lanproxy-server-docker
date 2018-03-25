#拉取代码
FROM alpine as git

WORKDIR /lanproxy

RUN apk update
RUN apk add git
RUN git clone https://github.com/ffay/lanproxy.git ./

#编译代码
FROM maven as maven

WORKDIR /lanproxy

COPY --from=git /lanproxy ./

RUN mvn compile package -pl proxy-server -am 

RUN cd distribution && DIR_NAME=$(echo `ls` | awk '{print $NF}') && mv $DIR_NAME /lanproxy/lanproxy-server
#RUN mvn help:evaluate -Dexpression=project.version

#RUN VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"` && cd distribution && mv proxy-server-${VERSION} proxy-server

# RUN cd distribution/proxy-server/bin && mv startup.sh startup.bak && cat startup.bak > startup.sh && rm startup.bak && chmod 755 startup.sh


#编译Docker镜像
FROM openjdk:8-jdk-alpine

WORKDIR /lanproxy-server

COPY --from=maven /lanproxy/lanproxy-server ./

# RUN chmod 755 bin/startup.sh

EXPOSE 8090

CMD ["sh", "-c", "sh bin/startup.sh && tail -f logs/server.log"]
