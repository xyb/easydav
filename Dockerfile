FROM linuxserver/nginx

COPY ./config/nginx/nginx.conf /config/nginx/nginx.conf
COPY ./config/log/nginx/.keep /config/log/nginx/
COPY ./config/init.sh /config/init.sh

EXPOSE 80

ENV WEBDAV_USER=user
ENV WEBDAV_PASSWORD=pwd

ENTRYPOINT ["/bin/bash", "/config/init.sh"]
