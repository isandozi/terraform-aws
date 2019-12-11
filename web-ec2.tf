# This script can be omitted since we have autoscaling included in this module and ec2 instances are being launched with auto scaling groups

locals {
  env_tag = {
    Environment = terraform.workspace
  }



  //web_tags = merge(var.web_tags, local.env_tag)
}

resource "aws_instance" "web" {
  count         = var.web_ec2_count
  ami           = var.web_amis[var.region]
  instance_type = var.web_instance_type
  subnet_id     = local.pub_sub_ids[count.index]
  //  tags                   = local.web_tags
  user_data              = file("scripts/apache.sh")
  iam_instance_profile   = aws_iam_instance_profile.s3_ec2_profile.name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.web.key_name
}

resource "aws_key_pair" "web" {
  key_name   = "javahome-web"
  public_key = file("scripts/web.pub")
}
