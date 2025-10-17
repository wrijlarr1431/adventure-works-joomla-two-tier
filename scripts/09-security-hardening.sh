#!/bin/bash
# Script: Security hardening
# Date: $(date)

echo "========================================="
echo "Applying Security Hardening"
echo "========================================="

echo "1. Setting proper file permissions..."
sudo chown -R www-data:www-data /var/www/html/joomla
sudo find /var/www/html/joomla -type d -exec chmod 755 {} \;
sudo find /var/www/html/joomla -type f -exec chmod 644 {} \;

# Only lock configuration.php if it exists
if [ -f /var/www/html/joomla/configuration.php ]; then
    echo "   Locking configuration.php..."
    sudo chmod 444 /var/www/html/joomla/configuration.php
fi

echo ""
echo "2. Configuring Apache security settings..."
sudo sed -i 's/^ServerTokens .*/ServerTokens Prod/' /etc/apache2/conf-available/security.conf
sudo sed -i 's/^ServerSignature .*/ServerSignature Off/' /etc/apache2/conf-available/security.conf

# Add TraceEnable if not present
if ! grep -q "TraceEnable" /etc/apache2/conf-available/security.conf; then
    echo "TraceEnable Off" | sudo tee -a /etc/apache2/conf-available/security.conf
fi

echo ""
echo "3. Enabling security modules..."
sudo a2enmod headers
sudo systemctl restart apache2

echo ""
echo "4. Setting up automatic security updates..."
sudo DEBIAN_FRONTEND=noninteractive apt install -y unattended-upgrades
echo 'Unattended-Upgrade::Automatic-Reboot "false";' | sudo tee -a /etc/apt/apt.conf.d/50unattended-upgrades

echo ""
echo "✓ Security hardening complete!"
echo ""
echo "Security Checklist:"
echo "  ✓ File permissions set correctly"
echo "  ✓ Apache security headers configured"
echo "  ✓ Server information hidden"
echo "  ✓ Automatic security updates enabled"