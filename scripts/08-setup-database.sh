#!/bin/bash
# Script: Setup Joomla database
# Date: $(date)

echo "========================================="
echo "Setting Up Joomla Database on RDS"
echo "========================================="

# Prompt for RDS details
echo ""
read -p "Enter RDS Endpoint (e.g., xxx.us-east-1.rds.amazonaws.com): " RDS_ENDPOINT
read -p "Enter RDS Master Username [default: admin]: " RDS_USER
RDS_USER=${RDS_USER:-admin}
echo ""
read -sp "Enter RDS Master Password: " RDS_PASS
echo ""
echo ""

# Test connection first
echo "Testing database connection..."
if mysql -h "$RDS_ENDPOINT" -u "$RDS_USER" -p"$RDS_PASS" -e "SELECT 1;" > /dev/null 2>&1; then
    echo "✓ Database connection successful!"
else
    echo "✗ Database connection failed!"
    echo "Please check your endpoint, username, and password."
    exit 1
fi

# Create Joomla user and grant privileges
echo ""
echo "Creating Joomla database user..."
mysql -h "$RDS_ENDPOINT" -u "$RDS_USER" -p"$RDS_PASS" <<EOF
CREATE USER IF NOT EXISTS 'joomlauser'@'%' IDENTIFIED BY 'JoomlaSecurePass2024!';
GRANT ALL PRIVILEGES ON joomladb.* TO 'joomlauser'@'%';
FLUSH PRIVILEGES;
EOF

# Verify user creation
echo "Verifying user creation..."
mysql -h "$RDS_ENDPOINT" -u "$RDS_USER" -p"$RDS_PASS" -e "SELECT user, host FROM mysql.user WHERE user = 'joomlauser';"

echo ""
echo "✓ Database setup complete!"
echo ""
echo "========================================="
echo "Joomla Database Connection Details"
echo "========================================="
echo "Database Type: MySQLi"
echo "Database Host: $RDS_ENDPOINT"
echo "Database Name: joomladb"
echo "Database Username: joomlauser"
echo "Database Password: JoomlaSecurePass2024!"
echo "Table Prefix: Leave default (or customize)"
echo "========================================="
echo ""
echo "Save these details for Joomla installation!"