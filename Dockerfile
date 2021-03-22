#define distributive
FROM debian:buster
#show that we are alive
RUN echo "I'm starting to be created"
#short info
LABEL project_name="ft_server"
LABEL project_version="1.0.0"
LABEL desctiption="My first project with docker"
LABEL maintainer="cbleadr@gmail.com"


CMD sh ./srcs/run_update.sh
CMD sh ./srcs/preinstall.sh

#change working directory
WORKDIR /var/www/site
#PHP admin
CMD sh ./srcs/prepare_php.sh
#WordPress
CMD sh ./srcs/prepare_wordpress.sh
#nginx
CMD sh ./srcs/prepare_nginx.sh

COPY ./srcs/start_server.sh .

#make plush SSL
RUN openssl req -x509 -newkey -nodes rsa:4096 -days 90 \
		-keyout ./etc/ssl.key -out ./etc/ssl.crt \ 
		-subj '/CN=localhost';


# change Auth and init
RUN chown -R www-data /var/www/*
RUN chmod -R 755 /var/www/*

EXPOSE 80 443
CMD sh start_server.sh
