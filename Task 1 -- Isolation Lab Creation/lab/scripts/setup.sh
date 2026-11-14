
#!/bin/bash

# CleanCity DVWA Lab Setup Script
# Operating System: Ubuntu 22.04

# Stop script if any command fails
set -e

# Step 1: Update Ubuntu packages
echo "Updating packages..."
sudo apt update

# Step 2: Install Apache, MariaDB, PHP and Git
echo "Installing required software..."
sudo apt install -y apache2 mariadb-server php php-mysqli php-gd php-curl php-mbstring php-xml git

# Step 3: Start Apache and MariaDB services
echo "Starting services..."
sudo systemctl enable --now apache2
sudo systemctl enable --now mariadb

# Step 4: Download DVWA from GitHub
echo "Downloading DVWA..."
if [ ! -d /var/www/html/DVWA ]; then
    sudo git clone https://github.com/digininja/DVWA.git /var/www/html/DVWA
else
    echo "DVWA folder already exists."
fi

# Step 5: Create DVWA configuration file
echo "Configuring DVWA..."
if [ ! -f /var/www/html/DVWA/config/config.inc.php ]; then
    sudo cp /var/www/html/DVWA/config/config.inc.php.dist \
    /var/www/html/DVWA/config/config.inc.php
fi

# Step 6: Set permissions for Apache
sudo chown -R www-data:www-data /var/www/html/DVWA

# Step 7: Restart Apache
sudo systemctl restart apache2

# Display completion message
echo "DVWA installation completed!"
echo "Configure the database before opening DVWA."
echo "Open: http://localhost/DVWA/setup.php"
