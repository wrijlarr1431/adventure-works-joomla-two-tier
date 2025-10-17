Two‑Tier Joomla on AWS (EC2 + RDS) — VS Code + Terminal + Git Workflow (http://bit.ly/4qeVKx1)

A repeatable, script‑driven workflow to deploy Joomla 4.x on AWS with a clean two‑tier architecture:

Web tier: EC2 (Ubuntu 22.04, Apache 2.4, PHP 8.x)
Data tier: Amazon RDS (MySQL 8, private subnets)
Dev workflow: VS Code Remote‑SSH, macOS Terminal, Git/GitHub

Read the full write‑up on Medium: Creating a Two‑Tier Joomla Travel Website on AWS — My VS Code + Terminal + Git Workflow

Why this repo
Treat servers like code: small, modular bash scripts you can re‑run safely
Keep infra steps versioned, reviewable, and reusable
Make EC2 feel local via VS Code Remote‑SSH
Architecture
VPC with public (web) and private (DB) subnets
EC2 in public subnet with Security Group:
Inbound: 22 (your IP), 80/443 (world)
RDS MySQL in private subnets with Security Group:
Inbound: 3306 from the web SG only
No public access to the database
Optional: Internet Gateway (public side only). No NAT Gateway required.
Tech stack
OS: Ubuntu 22.04 LTS
Web: Apache 2.4, PHP 8.x, Joomla 4.4.x
DB: MySQL 8 (Amazon RDS)
Tools: VS Code (Remote‑SSH), macOS Terminal, Git/GitHub
Repo layout
.
├─ scripts/
│  ├─ 01-update-system.sh
│  ├─ 02-install-webserver.sh
│  ├─ 03-install-php.sh
│  ├─ 04-install-mysql-client.sh
│  ├─ 05-download-joomla.sh
│  ├─ 06-configure-apache.sh
│  ├─ 07-configure-php.sh
│  ├─ 08-setup-database.sh
│  ├─ 09-security-hardening.sh
│  └─ install-all.sh
├─ configs/         # vhost examples, php.ini snippets, DB params (no secrets)
├─ docs/            # setup notes, logs, screenshots
└─ README.md

Prerequisites
AWS account with permissions to create EC2, RDS, VPC resources
SSH key pair (.pem) and your Mac’s public IP
VS Code + Remote‑SSH extension
A GitHub account and this repo cloned/pulled
Quick start
Launch EC2 (web tier)
Ubuntu 22.04 LTS, t2.micro/t3.micro
Public subnet with route to Internet Gateway
Security Group:
22/tcp from your IP (e.g., 203.0.113.10/32)
80, 443 from 0.0.0.0/0
Configure VS Code Remote‑SSH Add to ~/.ssh/config:
Host joomla-web
  HostName <EC2_PUBLIC_IP>
  User ubuntu
  IdentityFile ~/.ssh/aws-keys/your-key.pem
  ServerAliveInterval 60


Key hygiene:

chmod 700 ~/.ssh
chmod 400 ~/.ssh/aws-keys/your-key.pem


Connect: VS Code → Remote‑SSH → joomla‑web.

Create RDS MySQL (data tier)
Engine: MySQL 8, db.t3.micro
Private subnets, not publicly accessible
DB Subnet Group configured
DB name: joomladb
Master user: admin
DB SG: allow 3306 from the Web SG only
Save endpoint and credentials securely
Pull scripts on EC2
sudo apt update && sudo apt install -y git
git clone https://github.com/<you>/<repo>.git
cd <repo>/scripts
chmod +x *.sh

Provision web server
./install-all.sh


What it does:

Updates system
Installs Apache + modules
Installs PHP 8.x + extensions
Installs MySQL client
Downloads Joomla to /var/www/html/joomla
Sets up Apache vhost + rewrite
Applies PHP tuning
Prepare Joomla DB access
./08-setup-database.sh

Enter RDS endpoint + admin credentials
Creates joomlauser and grants least‑privileged access on joomladb
Outputs DB connection values for the installer
Run the Joomla installer
Visit: http://<EC2_PUBLIC_IP>
Database:
Type: MySQLi
Host: <RDS_ENDPOINT>
Database: joomladb
User: joomlauser
Password: <from step 6>
After install, harden:
sudo rm -rf /var/www/html/joomla/installation

Verify
Frontend: http://<EC2_PUBLIC_IP>
Admin: http://<EC2_PUBLIC_IP>/administrator
Security hardening

Run:

./09-security-hardening.sh


Includes:

File permissions
Hide server signature/tokens
Security headers
Unattended upgrades
Teardown / Avoid charges
EC2: terminate instance; delete orphaned EBS volumes/snapshots; release EIPs
RDS: delete DB (and snapshots if not needed)
Ensure no NAT Gateway is running
Remove unused S3 objects, CloudWatch log groups, Route 53 hosted zones
Troubleshooting
Can’t SSH: confirm SG 22/tcp from your IP, correct .pem perms, correct user (ubuntu)
Joomla can’t reach DB: confirm DB SG allows 3306 from Web SG, correct RDS endpoint, MySQL client can connect:
mysql -h <RDS_ENDPOINT> -u admin -p

Apache not serving: check service and vhost
sudo systemctl status apache2
sudo a2ensite joomla && sudo systemctl reload apache2

PHP extensions: verify
php -m | grep -E "mysqli|mbstring|json|xml|zip|curl|gd"

Screenshots (optional)
VS Code Remote‑SSH connected
Repo structure
SG rules
RDS details
install-all.sh output
Apache vhost file
Joomla installer DB screen
Live homepage + admin panel
Roadmap / Variations
TLS with Let’s Encrypt (Certbot)
CloudFront + S3 for media offload
Autoscaling group + ALB for web tier
Terraform/CloudFormation conversion
GitHub Actions for remote deploys

Built with VS Code, Terminal, and Git
