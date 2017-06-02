# use a node base image
FROM node:7-onbuild


ARG test1
ARG test2
ARG test3

ENV TEST1=$test1
ENV TEST2=$test2
ENV TEST3=$test3


# set maintainer
LABEL maintainer "miiro@getintodevops.com"

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8000 || exit 1

# tell docker what port to expose
EXPOSE 8000
