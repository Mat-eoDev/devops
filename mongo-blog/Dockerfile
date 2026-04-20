FROM mongo:7.0-jammy

COPY init-blog.js /docker-entrypoint-initdb.d/

RUN groupadd -r bloguser && useradd -r -g bloguser -d /home/bloguser -s /bin/bash bloguser \
    && mkdir -p /home/bloguser /data/db \
    && chown -R bloguser:bloguser /data/db /home/bloguser

USER bloguser

EXPOSE 27017

CMD ["mongod", "--bind_ip_all"]
