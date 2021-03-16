variable "vpc" {
  type = map
  default = {
    "vpc-name"  = "terraform"
    "cidr-block" = "172.9.0.0/16"
  }
}

variable "subnet" {
  type = map
  default = {
    "subnet-name"  = "terraform"
    "subnet-cidr-block" = "172.9.0.0/20"
  }
}

variable "internetgw" {
  type        = map
  default     = {
    "internetgw-name" = "terraform"
  }
}


variable "routetable" {
  type        = map
  default     = {
    "routetable-name" = "terraform"
  }
}

variable "securitygroup" {
  type        = map
  default     = {
    "securitygroup-name" = "terraform"
  }
}


