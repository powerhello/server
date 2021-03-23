#define distributive
FROM debian:buster
#show that we are alive
RUN echo "I'm starting to be created"
#short info
LABEL project_name="ft_server"
LABEL project_version="1.0.0"
LABEL desctiption="My first project with docker"
LABEL maintainer="cbleadr@gmail.com"

# WORKDIR /var/www/site
# WORKDIR /
COPY ./srcs/start_server.sh .
COPY ./srcs/prepare_php.sh .
COPY ./srcs/prepare_nginx.sh .
COPY ./srcs/run_update.sh .
COPY ./srcs/preinstall.sh .
COPY ./srcs/prepare_wordpress.sh .



# RUN bash ./srcs/run_update.sh
# RUN bash run_update.sh
RUN apt-get update -y; apt-get upgrade -y
# RUN bash ./srcs/preinstall.sh
# RUN bash preinstall.sh
RUN apt-get -y install wget nginx vim php php-mysql php-mbstring php-fpm php-zip mariadb-server

#change working directory
WORKDIR /var/www/site
WORKDIR /
# #PHP admin
# CMD bash ./srcs/prepare_php.sh
RUN bash prepare_php.sh
COPY ./srcs/php_config.inc.php /var/www/site/phpMyAdmin
# #WordPress
# CMD bash ./srcs/prepare_wordpress.sh
RUN bash prepare_wordpress.sh
COPY ./srcs/wp_config.php /var/www/site/wordPress




#make plush SSL
# CMD ["/bin/bash", "-c", "openssl req -x509 -newkey -nodes rsa:4096 -days 90 \
# 		-keyout /etc/ssl/certs/ssl.key \
# 		-out /etc/ssl/private/ssl.crt \ 
# 		-subj '/CN=localhost';"]
# RUN openssl req -x509 -newkey -nodes rsa:2048 -keyout /etc/ssl/certs/ssl.key -out /etc/ssl/private/ssl.crt -days 90  -subj '/CN=localhost'
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-out /etc/ssl/private/ssl.crt \
	-keyout /etc/ssl/certs/ssl.key \
	-subj "/C=RU/ST=Tatarstan/L=Kazan/O=Ecole/OU=21/CN=localhost"

#nginx
# CMD bash ./srcs/prepare_nginx.sh
# RUN bash prepare_nginx.sh
COPY ./srcs/nginx.conf /etc/nginx/sites-available/nginx.conf
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf


# change Auth and init
RUN chown -R www-data /var/www/*
RUN chmod -R 755 /var/www/*
RUN chmod -R 755 start_server.sh
EXPOSE 80 443
CMD bash start_server.sh
