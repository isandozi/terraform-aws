resource "aws_lb_target_group" "javahome" {
  name     = var.lb_tg_name
  port     = var.http_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_app.id
}

resource "aws_lb_target_group_attachment" "javahome" {
  count            = var.web_ec2_count
  target_group_arn = aws_lb_target_group.javahome.arn
  target_id        = aws_instance.web.*.id[count.index]
  port             = var.http_port
}
resource "aws_lb" "javahome" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = local.pub_sub_ids

  access_logs {
    bucket  = aws_s3_bucket.alb_access_logs.bucket
    prefix  = var.prefix
    enabled = true
  }

  tags = {
    Environment = terraform.workspace
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.javahome.arn
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.javahome.arn
  }
}

/*data "template_file" "javahome" {
  template = file("scripts/iam/alb-s3-access-logs.json")
  vars = {
    access_logs_bucket = var.alb_s3_logs
  }
}
*/
