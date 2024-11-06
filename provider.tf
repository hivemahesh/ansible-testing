provider "aws" {
    region = var.aws_region
}

terraform {
    required_version = "<= 1.7.0" #Forcing which version of terraform needs to be used
    required_providers {
      aws = {
        version = "<= 6.0.0"  #Forcing which version of plugin needs to be used.
        source = "hashicorp/aws"
      }
    }

    backend "s3" {
        bucket = "workspacebucketnov"  #upfront create the bucket in S3
        key = "Ansible.tfstate"
        region = "ap-south-1"
        #dynamodb_table = "-terraform-locks"
        encrypt = true
    }
}