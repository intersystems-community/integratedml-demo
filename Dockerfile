FROM docker.iscinternal.com/intersystems/iris:2020.2.0ML.232.0

# copy files
COPY data /data
COPY iris.script /tmp/iris.script
COPY iris.key /usr/irissys/mgr/iris.key

# load demo stuff
RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script

USER root
RUN rm /data/*
USER irisowner
