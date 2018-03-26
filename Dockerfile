FROM ubuntu
RUN apt-get update
RUN apt-get install -y git wget unzip
# interpreter for zork on linux
CMD ["apt-get", "install", "-y", "frotz"]
RUN mkdir /zorkzip/
# download game
# we need to spoof our user agent so we don't get rejected
RUN wget -U 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4' -P /zorkzip/ http://infocom-if.org/downloads/zork1.zip
RUN unzip /zorkzip/zork1.zip -d /zorkzip
RUN rm /zorkzip/zork1.zip
RUN mkdir /zorkdata/
RUN mv /zorkzip/DATA/ZORK1.DAT /zorkdata/ZORK1.DAT
RUN rm -rf /zorkzip/
RUN useradd -ms /bin/bash frotz
RUN chown frotz -R /zorkdata
USER frotz
CMD /usr/frotz /zorkdata/ZORK1.DAT