# Adventure Works Setup Log

## Date: October 17, 2024

### Network Infrastructure Created

#### VPC
- Name: adventure-works-vpc
- CIDR: 10.0.0.0/16
- VPC ID: vpc-02adea5348b909d4f
- Created: 2025-10-16

#### Internet Gateway
- Name: adventure-works-igw
- IGW ID: igw-0ff76d943e5a93448 
- Attached to: vpc-02adea5348b909d4f

#### Subnets

**Public Subnet 1:**
- Name: adventure-works-public-subnet-1
- CIDR: 10.0.1.0/24
- AZ: us-east-1d
- Subnet ID: subnet-0a6ba92cb39673602

**Public Subnet 2:**
- Name: adventure-works-public-subnet-2
- CIDR: 10.0.2.0/24
- AZ: us-east-1d
- Subnet ID: subnet-076d0a01c4ae68741

**Private Subnet 1:**
- Name: adventure-works-private-subnet-1
- CIDR: 10.0.3.0/24
- AZ: us-east-1d
- Subnet ID: subnet-0ef67e7ac93aa04b0

**Private Subnet 2:**
- Name: adventure-works-private-subnet-2
- CIDR: 10.0.4.0/24
- AZ: us-east-1d
- Subnet ID: subnet-0345bde0bb4aa0277

#### Route Tables

**Public Route Table:**
- Name: adventure-works-public-rt
- Route Table ID: rtb-0a1b2c3d4e5f6g7h8
- Associated Subnets: public-subnet-1, public-subnet-2
- Routes:
  - 10.0.0.0/16 → local
  - 0.0.0.0/0 → igw-0a1b2c3d4e5f6g7h8

**Private Route Table:**
- Name: adventure-works-private-rt
- Route Table ID: rtb-1a2b3c4d5e6f7g8h9
- Associated Subnets: private-subnet-1, private-subnet-2
- Routes:
  - 10.0.0.0/16 → local

---

### EC2 Instance Configuration

#### Web Server Instance
- Name: adventure-works-web-server
- Instance Type: t2.micro
- AMI: Ubuntu Server 22.04 LTS (ami-0360c520857e3138f)
- Instance ID: i-03f54da7696a16be0
- Public IP: 54.237.203.12
- Private IP: 10.0.1.174
- Security Group: sg-06e55c276f81621ca (adventure-works-web-sg)
- Key Pair: adventure-works-key
- Subnet: adventure-works-public-subnet-1
- Created: 2024-10-16

#### Security Group Configuration

**Inbound Rules:**
- SSH (22) - Source: 97.103.206.154/32
- HTTP (80) - Source: 0.0.0.0/0
- HTTPS (443) - Source: 0.0.0.0/0

**Outbound Rules:**
- All traffic - Destination: 0.0.0.0/0

#### SSH Configuration
- Config file: ~/.ssh/config
- Host alias: adventure-works-web
- Key location: ~/.ssh/aws-keys/adventure-works-key.pem
- Permissions: 400 (-r--------)

#### Connection Verified
- Date: 2024-10-17 15:15:00 EST
- Method: VS Code Remote-SSH
- Status: ✓ Successful
- Connection Test: ping, apt update successful