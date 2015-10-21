FROM ahri/java:0.0.1

RUN apk add --update ttf-liberation=2.00.1-r0 ttf-linux-libertine-doc=5.3.0-r0 ttf-droid=20110607-r0 ttf-linux-libertine=5.3.0-r0 ttf-ubuntu-font-family=0.80-r0 ttf-dejavu=2.34-r0 ttf-freefont=20120503-r0 \
            font-misc-cyrillic=1.0.0-r2 font-misc-ethiopic=1.0.3-r0 font-misc-misc=1.0.0-r3 font-misc-meltho=1.0.1-r1 && \
        rm -rf /var/cache/apk/*

RUN adduser burp -D -s /bin/sh

ADD burp.sh /

ENV BURP_LICENSE="no license set"
EXPOSE 8080
USER burp
ENTRYPOINT ["/burp.sh"]
