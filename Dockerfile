FROM store/intersystems/iris-ml-community:2020.3.0.302.0

USER root
RUN mkdir /data \
	&& chown irisowner /data
USER irisowner

# copy files
COPY data /data
COPY iris.script /tmp/iris.script

# extract hate-speech dataset
RUN mkdir /data/hate-speech/ \
	&& tar -xf /data/hate-speech.tar -C /data/

# load demo stuff
RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly

USER root
RUN rm -r /data/*
USER irisowner