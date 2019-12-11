provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "terraform-practice"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-practice"
  }
}

/*
output "vpc_cidr" {
  value = "${aws_vpc.my_vpc.cidr_block}"
}
*/
