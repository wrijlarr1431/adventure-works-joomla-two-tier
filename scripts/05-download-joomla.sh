#!/bin/bash
# Script: Download and extract Joomla
# Date: $(date)

echo "========================================="
echo "Downloading Joomla CMS"
echo "========================================="

# Go to temp directory
cd /tmp

# Download Joomla
echo "Downloading Joomla 4.4.1..."
wget -q --show-progress https://downloads.joomla.org/cms/joomla4/4-4-1/Joomla_4-4-1-Stable-Full_Package.tar.gz

# Create Joomla directory
echo "Creating Joomla directory..."
sudo mkdir -p /var/www/html/joomla

# Extract Joomla
echo "Extracting Joomla files..."
sudo tar -xzf Joomla_4-4-1-Stable-Full_Package.tar.gz -C /var/www/html/joomla

# Set ownership
echo "Setting file ownership..."
sudo chown -R www-data:www-data /var/www/html/joomla

# Set permissions
echo "Setting file permissions..."
sudo chmod -R 755 /var/www/html/joomla

# Clean up
rm -f Joomla_4-4-1-Stable-Full_Package.tar.gz

echo ""
echo "✓ Joomla download and extraction complete!"
echo "Files located at: /var/www/html/joomla"