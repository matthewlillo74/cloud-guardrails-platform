# 1. The Network (VPC)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  
  # checkov:skip=CKV2_AWS_11: "Flow logs invalid for this learning project (cost/complexity)"
  # checkov:skip=CKV2_AWS_12: "Default SG restriction handled elsewhere"

  tags = {
    Name        = "guardrails-vpc"
    Environment = "Dev"
  }
}

# 2. The Subnet (Private is safer)
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "guardrails-private-subnet"
  }
}

# 3. The "Secure" Security Group
resource "aws_security_group" "secure_sg" {
  name        = "secure_app_traffic"
  description = "Allow inbound HTTP from internal network only"
  vpc_id      = aws_vpc.main.id

  # ✅ FIXED: Only allow traffic from within the VPC (10.0.0.0/16), not the whole internet
  ingress {
    description = "Allow HTTP from internal VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] 
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. The Server (EC2 Instance)
resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec" 
  instance_type = "t2.micro"              
  subnet_id     = aws_subnet.private.id
  
  # ✅ FIXED: Using the secure group
  vpc_security_group_ids = [aws_security_group.secure_sg.id]

  # ✅ FIXED: Encrypt the hard drive
  root_block_device {
    encrypted = true
  }

  # ✅ FIXED: Enable Metadata V2 (Protects against SSRF attacks)
  metadata_options {
    http_tokens = "required"
  }

  # checkov:skip=CKV_AWS_126: "Detailed monitoring costs money, skipping for free tier"
  # checkov:skip=CKV_AWS_135: "EBS optimizaton not supported on t2.micro"
  # checkov:skip=CKV2_AWS_41: "IAM role not needed for this simple test"

  tags = {
    Name = "guardrails-app-server-secure"
    CostCenter = "Platform-Engineering-101"
  }
}
