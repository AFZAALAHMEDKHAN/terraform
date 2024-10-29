variable "Region" {
  default = "us-east-1"
}

variable "Zones" {
  type = map(any)
  default = {
    a = "us-east-1a"
    b = "us-east-1b"
    c = "us-east-1c"
  }
}

variable "AMI" {
  type = map(any)
  default = {
    us-east-1 = "ami-06b21ccaeff8cd686"
    us-east-2 = "ami-050cd642fd83388e4"
  }

}
variable "Public_key" {
  default = "tfkey.pub"
}

variable "Private_key" {
  default = "tfkey"
}

variable "user" {
  default = "ec2-user"
}