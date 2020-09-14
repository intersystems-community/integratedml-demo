FROM store/intersystems/iris-aa-community:2020.3.0AA.331.0

# copy files
COPY data /data
COPY iris.script /tmp/iris.script
# Uncomment line below if you want to use a different image that requires a license key
#COPY iris.ISCkey /usr/irissys/mgr/iris.key

# load demo stuff
RUN iris start IRIS \
    && iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly

USER root
RUN rm -r /data/*
USER irisowner
