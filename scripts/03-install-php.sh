#!/bin/bash
# Script: Install PHP and required extensions
# Date: $(date)

echo "========================================="
echo "Installing PHP and Extensions"
echo "========================================="

# Install PHP and all required Joomla extensions
sudo apt install -y \
  php \
  libapache2-mod-php \
  php-mysql \
  php-xml \
  php-mbstring \
  php-zip \
  php-gd \
  php-curl \
  php-json

echo ""
echo "Checking PHP version..."
php -v

echo ""
echo "Restarting Apache to load PHP..."
sudo systemctl restart apache2

echo ""
echo "✓ PHP installation complete!"