FROM php:8.2

RUN apt-get update \
    && apt-get install -y \
        git \
    # Install node
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install --no-install-recommends -y nodejs \
    && node --version \
    && npm --version

# Install PHP extensions and Composer
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync \
    && install-php-extensions \
    xdebug \
    zip \
    @composer \
    && rm /usr/local/bin/install-php-extensions

RUN echo "alias jigsaw=./vendor/bin/jigsaw" >> ~/.bashrc && \
    echo "alias compile='./vendor/bin/jigsaw build'" >> ~/.bashrc && \
    /bin/bash -c "source ~/.bashrc"

COPY entrypoint.sh /var/www/scripts/
ENTRYPOINT [ "bash", "/var/www/scripts/entrypoint.sh" ]
