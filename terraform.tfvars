aws_region = "ap-south-1"
vpc_cidr = "10.37.0.0/16"
vpc_name = "Ansible-vpc"  # going to create vpc
key_name = "jenkinsppk"
public_subnet_cidrs = ["10.37.1.0/24", "10.37.2.0/24", "10.37.3.0/24"] # list
private_subnet_cidrs = ["10.37.10.0/24", "10.37.20.0/24", "10.37.30.0/24"]
azs = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
environment = "production"
instance_type = {
    development = "t2.small"
    testing = "t2.small"
    production = "t2.small"
}
amis = {
  ap-south-1 = "ami-0dee22c13ea7a9a67"   # taking AMI of ubuntu from our mumbai
  ap-northeast-2 = "ami-040c33c6a51fd5d96" # taking AMI of ubuntu from seoul 
}
projid = "PHOENIX-123"
imagename = "ami-0dee22c13ea7a9a67"