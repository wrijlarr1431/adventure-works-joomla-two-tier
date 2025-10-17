#!/bin/bash
# Script: Install Apache web server
# Date: $(date)

echo "========================================="
echo "Installing Apache Web Server"
echo "========================================="

# Install Apache
sudo apt install apache2 -y

# Start and enable Apache
echo "Starting Apache service..."
sudo systemctl start apache2
sudo systemctl enable apache2

# Check status
echo "Checking Apache status..."
sudo systemctl status apache2 --no-pager | head -5

echo ""
echo "✓ Apache installation complete!"
EC2_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "Visit http://$EC2_IP to verify Apache is running"