variable "instance" {
  type = map
  default = {
    "name"  = "terraform"
    "instance_type" = "t2.micro"
    "availability_zone"  = "ap-southeast-1a"
    ## need to add keypair name before going to another steps
    "key_pair_name" = "InstanceXXX"
  }
}

