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
# COPY ./srcs/prepare_php.sh .
# COPY ./srcs/prepare_nginx.sh .
# COPY ./srcs/run_update.sh .
# COPY ./srcs/preinstall.sh .
# COPY ./srcs/prepare_wordpress.sh .



# RUN bash ./srcs/run_update.sh
# RUN bash run_update.sh
RUN apt-get update -y; apt-get upgrade -y
# RUN bash ./srcs/preinstall.sh
# RUN bash preinstall.sh
RUN apt-get -y install wget nginx vim php7.3 php7.3-mysql php7.3-mbstring php7.3-fpm php7.3-zip php 7.3-xml mariadb-server

#change working directory
WORKDIR /var/www/site
WORKDIR /

# #PHP admin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz
RUN tar xvf phpMyAdmin-5.1.0-english.tar.gz
RUN rm phpMyAdmin-5.1.0-english.tar.gz
RUN mv phpMyAdmin-5.1.0-english/ var/www/site/phpmyadmin
COPY ./srcs/config.inc.php /var/www/site/phpmyadmin

# #WordPress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz
RUN rm latest.tar.gz
RUN mv wordpress/ var/www/site/wordpress
COPY ./srcs/wp-config.php /var/www/site/wordpress




#make plush SSL
RUN openssl req -x509 -nodes -days 90 -newkey rsa:2048 \
	-out /etc/ssl/certs/ssl.crt \
	-keyout /etc/ssl/private/ssl.key \
	-subj "/C=RU/ST=Tatarstan/L=Kazan/O=Ecole/OU=21/CN=localhost"

#nginx
COPY ./srcs/nginx.conf /etc/nginx/sites-available/nginx.conf
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf


# change Auth and init
RUN chown -R www-data /var/www/*
RUN chmod -R 755 /var/www/*
RUN chmod -R 755 start_server.sh
EXPOSE 80 443
CMD bash start_server.sh
