FROM php:8.2

WORKDIR /usr/src/novo-site

COPY . .

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

RUN apt-get update && \
    apt-get install git -y

RUN echo "alias jigsaw=./vendor/bin/jigsaw" >> ~/.bashrc && \
    echo "alias compile='./vendor/bin/jigsaw build'" >> ~/.bashrc && \
    /bin/bash -c "source ~/.bashrc"

EXPOSE 8000

ENTRYPOINT [ "./vendor/bin/jigsaw", "serve", "--host=0.0.0.0" ]