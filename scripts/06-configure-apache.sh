#!/bin/bash
# Script: Configure Apache for Joomla
# Date: $(date)

echo "========================================="
echo "Configuring Apache for Joomla"
echo "========================================="

# Get EC2 public IP
EC2_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "EC2 Public IP: $EC2_IP"

# Create Apache VirtualHost configuration
echo "Creating Apache configuration file..."
sudo tee /etc/apache2/sites-available/joomla.conf > /dev/null <<EOF
<VirtualHost *:80>
    ServerAdmin admin@adventureworks.com
    DocumentRoot /var/www/html/joomla
    ServerName $EC2_IP

    <Directory /var/www/html/joomla>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/joomla-error.log
    CustomLog \${APACHE_LOG_DIR}/joomla-access.log combined
</VirtualHost>
EOF

# Enable Joomla site
echo "Enabling Joomla site..."
sudo a2ensite joomla.conf

# Enable rewrite module (required for Joomla)
echo "Enabling Apache rewrite module..."
sudo a2enmod rewrite

# Disable default site
echo "Disabling default Apache site..."
sudo a2dissite 000-default.conf

# Test configuration
echo "Testing Apache configuration..."
sudo apache2ctl configtest

# Restart Apache
echo "Restarting Apache..."
sudo systemctl restart apache2

echo ""
echo "✓ Apache configuration complete!"
echo "Visit http://$EC2_IP to start Joomla installation"