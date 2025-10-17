#!/bin/bash
# Script: Master installation script for Adventure Works Joomla
# Date: $(date)

echo "========================================="
echo "  Adventure Works Joomla Installation"
echo "========================================="
echo ""
echo "This script will install and configure:"
echo "  - Apache Web Server"
echo "  - PHP and required extensions"
echo "  - MySQL Client"
echo "  - Joomla 4.4.1 CMS"
echo ""
read -p "Press Enter to continue or Ctrl+C to cancel..."

# Change to scripts directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Make all scripts executable
chmod +x *.sh

# Track start time
START_TIME=$(date +%s)

# Run installation scripts in sequence
echo ""
echo "================================================"
echo "Step 1/7: Updating System"
echo "================================================"
./01-update-system.sh
if [ $? -ne 0 ]; then echo "Error in system update!"; exit 1; fi

echo ""
echo "================================================"
echo "Step 2/7: Installing Apache Web Server"
echo "================================================"
./02-install-webserver.sh
if [ $? -ne 0 ]; then echo "Error installing Apache!"; exit 1; fi

echo ""
echo "================================================"
echo "Step 3/7: Installing PHP"
echo "================================================"
./03-install-php.sh
if [ $? -ne 0 ]; then echo "Error installing PHP!"; exit 1; fi

echo ""
echo "================================================"
echo "Step 4/7: Installing MySQL Client"
echo "================================================"
./04-install-mysql-client.sh
if [ $? -ne 0 ]; then echo "Error installing MySQL client!"; exit 1; fi

echo ""
echo "================================================"
echo "Step 5/7: Downloading Joomla"
echo "================================================"
./05-download-joomla.sh
if [ $? -ne 0 ]; then echo "Error downloading Joomla!"; exit 1; fi

echo ""
echo "================================================"
echo "Step 6/7: Configuring Apache"
echo "================================================"
./06-configure-apache.sh
if [ $? -ne 0 ]; then echo "Error configuring Apache!"; exit 1; fi

echo ""
echo "================================================"
echo "Step 7/7: Configuring PHP"
echo "================================================"
./07-configure-php.sh
if [ $? -ne 0 ]; then echo "Error configuring PHP!"; exit 1; fi

# Calculate duration
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

# Get EC2 IP
EC2_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

echo ""
echo "================================================"
echo "  ✓ INSTALLATION COMPLETE!"
echo "================================================"
echo ""
echo "Installation completed in $DURATION seconds"
echo ""
echo "Next Steps:"
echo "  1. Setup database: ./08-setup-database.sh"
echo "  2. Complete Joomla installation:"
echo "     Visit: http://$EC2_IP"
echo "  3. After Joomla setup, run security hardening:"
echo "     ./09-security-hardening.sh"
echo "  4. Test deployment:"
echo "     ./10-test-deployment.sh"
echo ""
echo "================================================"