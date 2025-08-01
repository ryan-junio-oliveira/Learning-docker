# ===============================
# ARGUMENTOS DA IMAGEM
# ===============================
ARG PHP_VERSION=8.2-fpm
FROM php:${PHP_VERSION}

ARG APP_DIR=/var/www

# ===============================
# DEPENDÊNCIAS DE SISTEMA
# ===============================
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    supervisor \
    samba \
    smbclient \
    nginx \
    zlib1g-dev \
    libzip-dev \
    unzip \
    libpng-dev \
    libpq-dev \
    libxml2-dev \
    librabbitmq-dev \
    libssl-dev \
    pkg-config \
    git \
    build-essential \
    wget \
    curl \
    xpdf \
    libjpeg-dev \
    libfreetype6-dev \
    libx11-dev \
    libxt-dev \
    libxext-dev \
    && rm -rf /var/lib/apt/lists/*

# ===============================
# GHOSTSCRIPT 9.54
# ===============================
RUN cd /tmp && \
    wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9540/ghostscript-9.54.0.tar.gz && \
    tar -xzf ghostscript-9.54.0.tar.gz && \
    cd ghostscript-9.54.0 && \
    ./configure && \
    make && \
    make install && \
    cd / && rm -rf /tmp/ghostscript-9.54.0*

# ===============================
# RBENV + RUBY 1.9.3 (LEGADO)
# ===============================
RUN apt-get update && apt-get install -y --no-install-recommends \
    libreadline-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm-dev \
    libdb-dev \
    bison \
    libyaml-dev \
    autoconf \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instala rbenv e ruby 1.9.3-p551
ENV RBENV_ROOT="/root/.rbenv"
ENV PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"

RUN git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT && \
    git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build && \
    $RBENV_ROOT/plugins/ruby-build/install.sh && \
    rbenv install 1.9.3-p551 && \
    rbenv global 1.9.3-p551 && \
    ln -s $RBENV_ROOT/shims/ruby /usr/local/bin/ruby && \
    ln -s $RBENV_ROOT/shims/gem /usr/local/bin/gem && \
    ruby -v

# ===============================
# INSTALAÇÃO DE GEMS LEGADAS
# ===============================
RUN gem install tilt -v 1.3.7 --no-ri --no-rdoc && \
    gem install sinatra -v 1.4.7 --no-ri --no-rdoc && \
    gem install haml -v 4.0.7 --no-ri --no-rdoc

# ===============================
# INSTALAÇÃO DO IMAGICK
# ===============================
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmagickwand-dev \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

# ===============================
# SUPERVISOR E NGINX
# ===============================
COPY ./docker/supervisord/supervisord.conf /etc/supervisor/
COPY ./docker/supervisord/conf /etc/supervisord.d/
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
# COPY ./docker/nginx/sites /etc/nginx/sites-available

# ===============================
# EXTENSÕES PHP
# ===============================
RUN docker-php-ext-install \
    sockets \
    mysqli \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    session \
    xml \
    zip \
    iconv \
    simplexml \
    pcntl \
    gd \
    fileinfo  

RUN pecl install amqp && docker-php-ext-enable amqp
RUN pecl install imagick && docker-php-ext-enable imagick

# ===============================
# COMPOSER
# ===============================
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# ===============================
# PHP INI
# ===============================
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

# ===============================
# CONFIGURAÇÕES DE PROJETO
# ===============================
WORKDIR ${APP_DIR}
RUN mkdir -p ${APP_DIR} && chown -R www-data:www-data ${APP_DIR}

COPY ./applications ${APP_DIR}
COPY ./setup.sh /usr/local/bin/setup.sh
COPY ./docker/imagemagick/policy.xml /etc/ImageMagick-6/policy.xml
RUN chmod +x /usr/local/bin/setup.sh
RUN chown -R www-data:www-data ${APP_DIR}

# ===============================
# CMD (runtime)
# ===============================
CMD ["/bin/bash", "-c", "/usr/local/bin/setup.sh && exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf"]
