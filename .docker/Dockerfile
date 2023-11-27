FROM php:8.2

COPY --from=composer:2.6.5 /usr/bin/composer /usr/bin/composer

RUN apt-get update && \
    apt-get install git -y

RUN echo "alias jigsaw=./vendor/bin/jigsaw" >> ~/.bashrc && \
    echo "alias compile='./vendor/bin/jigsaw build'" >> ~/.bashrc && \
    /bin/bash -c "source ~/.bashrc"

COPY entrypoint.sh /var/www/scripts/
ENTRYPOINT [ "bash", "/var/www/scripts/entrypoint.sh" ]
