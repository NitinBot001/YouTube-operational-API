# Use an official PHP image with Apache
FROM php:8.0-apache

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libapache2-mod-php \
    php-mysql \
    php-curl \
    php-json \
    php-mbstring \
    php-xml \
    php-zip \
    php-gd \
    php-sqlite3 \
    php-pgsql \
    curl \
    && docker-php-ext-install pdo_mysql

# Enable Apache rewrite module
RUN a2enmod rewrite

# Clone your forked repository into the Apache document root
RUN git clone https://github.com/NitinBot001/YouTube-operational-API.git /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies with Composer
RUN composer install

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
