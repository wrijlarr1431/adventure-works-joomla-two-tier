# Adventure Works Setup Log

## Date: [Current Date]

### Network Infrastructure Created

#### VPC
- Name: adventure-works-vpc
- CIDR: 10.0.0.0/16
- VPC ID: vpc-xxxxxxxxx
- Created: [timestamp]

#### Internet Gateway
- Name: adventure-works-igw
- IGW ID: igw-xxxxxxxxx
- Attached to: vpc-xxxxxxxxx

#### Subnets
Public Subnet 1:
- Name: adventure-works-public-subnet-1
- CIDR: 10.0.1.0/24
- AZ: us-east-1a
- Subnet ID: subnet-xxxxxxxxx

### EC2 Instance Configuration

#### Web Server Instance
- Name: adventure-works-web-server
- Instance Type: t2.micro
- AMI: Ubuntu Server 22.04 LTS
- Instance ID: i-0123456789abcdef0
- Public IP: 54.123.456.789
- Private IP: 10.0.1.45
- Security Group: adventure-works-web-sg (sg-0abc123def456)
- Key Pair: adventure-works-key
- Created: [Current Date/Time]

#### Security Group Configuration
Inbound Rules:
- SSH (22) - Source: [Your Mac's IP]/32
- HTTP (80) - Source: 0.0.0.0/0
- HTTPS (443) - Source: 0.0.0.0/0

Outbound Rules:
- All traffic - Destination: 0.0.0.0/0

#### SSH Configuration
- Config file: ~/.ssh/config
- Host alias: adventure-works-web
- Key location: ~/.ssh/aws-keys/adventure-works-key.pem
- Permissions: 400

#### Connection Verified
- Date: [Current Date/Time]
- Method: VS Code Remote-SSH
- Status: ✓ Successful