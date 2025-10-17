#!/bin/bash
# Script: Install MySQL client
# Date: $(date)

echo "========================================="
echo "Installing MySQL Client"
echo "========================================="

sudo apt install mysql-client -y

echo ""
echo "Checking MySQL client version..."
mysql --version

echo ""
echo "✓ MySQL client installation complete!"