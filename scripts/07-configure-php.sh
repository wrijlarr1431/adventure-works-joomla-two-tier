#!/bin/bash
# Script: Configure PHP for Joomla
# Date: $(date)

echo "========================================="
echo "Configuring PHP Settings"
echo "========================================="

# Detect PHP version
PHP_VERSION=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')
PHP_INI="/etc/php/$PHP_VERSION/apache2/php.ini"

echo "PHP Version: $PHP_VERSION"
echo "Configuration file: $PHP_INI"

# Backup original php.ini
echo "Backing up php.ini..."
sudo cp $PHP_INI ${PHP_INI}.backup

# Update PHP settings for Joomla
echo "Updating PHP settings..."
sudo sed -i 's/^upload_max_filesize = .*/upload_max_filesize = 64M/' $PHP_INI
sudo sed -i 's/^post_max_size = .*/post_max_size = 64M/' $PHP_INI
sudo sed -i 's/^memory_limit = .*/memory_limit = 256M/' $PHP_INI
sudo sed -i 's/^max_execution_time = .*/max_execution_time = 300/' $PHP_INI

# Verify changes
echo ""
echo "Verifying PHP settings..."
echo "upload_max_filesize: $(php -r 'echo ini_get("upload_max_filesize");')"
echo "post_max_size: $(php -r 'echo ini_get("post_max_size");')"
echo "memory_limit: $(php -r 'echo ini_get("memory_limit");')"
echo "max_execution_time: $(php -r 'echo ini_get("max_execution_time");')"

# Restart Apache
echo ""
echo "Restarting Apache..."
sudo systemctl restart apache2

echo ""
echo "✓ PHP configuration complete!"