# 1. The Network (VPC)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name        = "guardrails-vpc"
    Environment = "Dev"
  }
}

# 2. The Subnet (A slice of the network)
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "guardrails-public-subnet"
  }
}

# 3. The "Bad" Security Group (We will fix this with policy later)
resource "aws_security_group" "allow_all" {
  name        = "allow_all_traffic"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # 🚨 Security Risk!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. The Server (EC2 Instance)
resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec" # Ubuntu 22.04 in us-east-1
  instance_type = "t2.micro"              # Free tier eligible
  subnet_id     = aws_subnet.public.id
  
  # We are intentionally attaching the risky security group
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "guardrails-app-server"
  }
}
