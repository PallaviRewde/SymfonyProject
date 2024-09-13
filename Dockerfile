# Use the official PHP 8.0 image with Apache
FROM php:8.0-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y libicu-dev libpq-dev libzip-dev unzip \
    && docker-php-ext-install intl pdo pdo_mysql zip \
    && a2enmod rewrite

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set the working directory
WORKDIR /var/www/html

# Copy the application code
COPY . /var/www/html

# Install Symfony dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose port 80
EXPOSE 80

