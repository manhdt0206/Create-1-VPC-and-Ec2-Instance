#data "aws_ami" "ubuntu" {
#  most_recent = true

#  filter {
#    name   = "name"
#    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#  }

 # filter {
 #   name   = "virtualization-type"
 #   values = ["hvm"]
#  }

#  owners = ["099720109477"] # Canonical
#}

#1.Create instance

resource "aws_instance" "main" {
  ami           = "ami-0c65e8b52315f51f8"
  instance_type = var.instance["instance_type"]
  availability_zone = var.instance["availability_zone"]

  #key pair of Instance
  key_name = var.instance["key_pair_name"]
  #Monitoring
  monitoring = true
  #Subnet of instance
  subnet_id = aws_subnet.main.id

  #Allow instance access internet
  associate_public_ip_address = true

vpc_security_group_ids = [aws_security_group.main.id]
# security_groups = [aws_security_group.main.id]

#root Storage of Instance
  root_block_device  {
    encrypted = false
    volume_size = 30
    delete_on_termination = true
  }

#IAM PROFILE
#iam_instance_profile = {}

#network_interface
#network_interface {
#  delete_on_termination = true  
#  network_interface_id = aws_network_interface.main.id
#  device_index = 1
#}

  tags = {
    Name = var.instance["name"]
  }

#Instance created after VPC
  depends_on = [aws_vpc.main]
}
