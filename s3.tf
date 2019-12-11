resource "aws_s3_bucket" "my_bucket" {
  bucket = var.my_app_s3_bucket
  acl    = "private"
  region = var.region

  tags = {
    Name        = "javahome-app-dev"
    Environment = terraform.workspace
  }
}

data "aws_elb_service_account" "javahome" {}

resource "aws_s3_bucket" "alb_access_logs" {
  bucket        = var.alb_s3_logs
  force_destroy = "true"
  acl           = "private"
  region        = var.region
  tags = {
    Name        = "jalb-access-logs"
    Environment = terraform.workspace
  }
  policy = templatefile("${path.module}/scripts/iam/alb-s3-access-logs.json", {
    bucket_name = var.alb_s3_logs
    prefix      = var.prefix
    policy_arn  = data.aws_elb_service_account.javahome.arn
    }
  )
  //policy = data.template_file.javahome.rendered
}
