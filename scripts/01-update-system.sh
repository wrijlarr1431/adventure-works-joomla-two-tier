#!/bin/bash
# Script: Update Ubuntu system
# Date: $(date)

echo "========================================="
echo "Updating Ubuntu System Packages"
echo "========================================="

sudo apt update
sudo apt upgrade -y

echo ""
echo "✓ System update complete!"