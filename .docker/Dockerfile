FROM php:8.3

ARG NODE_MAJOR=20

RUN apt-get update \
    && apt-get install -y \
        git \
        # Pacotes necessários para instalação do Node.js via NodeSource distributions
        ca-certificates \
        curl \
        gnupg \
    # Instala Node.js (veja https://github.com/nodesource/distributions)
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install nodejs -y \
    && node --version \
    && npm --version \
    # Limpa cache de pacotes
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions and Composer
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync \
    && install-php-extensions \
    xdebug \
    zip \
    @composer \
    && rm /usr/local/bin/install-php-extensions

RUN echo "alias jigsaw=./vendor/bin/jigsaw" >> /etc/bash.bashrc && \
    echo "alias compile='./vendor/bin/jigsaw build'" >> /etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc"

COPY entrypoint.sh /var/www/scripts/
ENTRYPOINT [ "bash", "/var/www/scripts/entrypoint.sh" ]
WORKDIR /var/www/html
