terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.57.0"
    }
  }
}
resource "aws_s3_bucket" "asif-backend-module" {
  bucket = "asif-backend-modul"
  tags = {
    "purpose" = "storing-backend-tfstate"
  }
}

resource "aws_dynamodb_table" "dynamo-module" {
  name         = "asif-module-dynamodbd-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

provider "aws" {
  # Configuration options
  access_key = var.akey
  secret_key = var.skey
  region     = var.location
}

# module "ec2-instance" {
#   source              = "terraforterraform-aws-modules/ec2-instance/aws"
#   version             = "5.6.1"
# module "ec2-instance" {
#   source              = "terraform-aws-modules/ec2-instance/aws//examples/complete"
#   version             = "5.6.1"
#   ami                 = "ami-0ec0e125bb6c6e8ec"
#   associate_public_ip = true
#   instance_type       = "t2.nano"
# #   name                = "asif-ec2-instance"
# }

module "ec2-instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "5.6.1"
  ami                         = "ami-0ec0e125bb6c6e8ec"
  associate_public_ip_address = true
  # availability_zone = "null"
  instance_type = "t2.nano"
  name          = "asif-wipro-ec2-module1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0"
  cidr    = "100.100.0.0/22"
  name    = "asif-vpc-module"
}
