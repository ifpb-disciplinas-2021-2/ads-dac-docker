# FROM alpine
# WORKDIR /app/src
# RUN mkdir data
# VOLUME [ "data" ]
# EXPOSE 9090
# COPY Principal.java Principal.java
# # listando os arquivos da pasta data
# CMD ls data


FROM openjdk:8-jdk-alpine
# ADD https://raw.githubusercontent.com/ifpb-disciplinas-2020-2/ads-dac-docker/main/exemplo-03/Principal.java Principal.java
COPY Principal.java Principal.java
# COPY start.sh start.sh
RUN javac Principal.java
EXPOSE 8080
## shell /bin/sh -c 'java Principal'
CMD java Principal
## exec java Principal
# CMD ["java" ,"Principal"]
# ENTRYPOINT  ["java" ,"Principal"]
# ENTRYPOINT ["/bin/sh", "start.sh" ]


