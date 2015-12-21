FROM ahri/java:0.0.2

RUN apk add --update ttf-dejavu=2.34-r0 \
            openssl && \
        rm -rf /var/cache/apk/*

RUN adduser burp -D -s /bin/sh

ADD burp-config.jar /
ADD burp.sh /

ENV BURP_LICENSE="no license set"
EXPOSE 8080
USER burp
ENTRYPOINT ["/burp.sh"]
