#1.Create VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc["cidr-block"]
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags = {
    Name = var.vpc["vpc-name"]
  }
}


#2.Create subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet["subnet-cidr-block"]
  availability_zone = var.instance["availability_zone"]
 #it makes this a public subnet, true = public, false = private
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet["subnet-name"]
  }
}

#3.Create Internet Gateway - It enables your vpc to connect to the internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.internetgw["internetgw-name"]
  }
}


#4.Create Route table - Create a custom route table for public subnet. public subnet can reach to the internet by using this.
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

#Route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = var.routetable["routetable-name"]
  }
}


#5.Route table Associations with Subnet 
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

#6.Route table Associations with VPC  
resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.main.id
}

#7.Create Security group
resource "aws_security_group" "main" {
  name        = "main"
  description = "Internet access"
  vpc_id      = aws_vpc.main.id

#Inbound rule
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "ping"
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

    ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

      ingress {
    description = "VNC"
    from_port   = 5901
    to_port     = 5901
    protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

#Outbound Rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.securitygroup["securitygroup-name"]
  }

#Create VPC before security group
  depends_on = [aws_vpc.main]
}



#8.Network interface
#create Network interface
#resource "aws_network_interface" "main" {
#  subnet_id       = aws_subnet.main.id
#tags = {
#    Name = var.vpc["vpc-name"]
#  }
#}

#Attact Security group to Network interface
#resource "aws_network_interface_sg_attachment" "main" {
#  security_group_id    = aws_security_group.main.id
#  network_interface_id = aws_network_interface.main.id
#}

#Attact Network interface to Instance
#resource "aws_network_interface_attachment" "main" {
#  instance_id          = aws_instance.main.id
#  network_interface_id = aws_network_interface.main.id
#  device_index         = 1
#}

