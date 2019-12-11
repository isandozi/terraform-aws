resource "aws_launch_configuration" "web_lc" {
  name                 = var.launch_configuration_name
  image_id             = var.web_amis[var.region]
  instance_type        = var.launch_configuration_instance
  key_name             = aws_key_pair.web.key_name
  user_data            = file("scripts/apache.sh")
  iam_instance_profile = aws_iam_instance_profile.s3_ec2_profile.name
  security_groups      = [aws_security_group.elb_sg.id]
}

resource "aws_autoscaling_group" "javahome_asg" {
  name     = var.autoscaling_group_name
  min_size = var.autoscaling_min
  max_size = var.autoscaling_max

  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  load_balancers            = [aws_elb.javahome_elb.name]
  vpc_zone_identifier       = local.pub_sub_ids
  launch_configuration      = aws_launch_configuration.web_lc.name
}

resource "aws_autoscaling_policy" "AddInstancesPolicy" {
  name                   = var.add_instances_policy
  scaling_adjustment     = var.add_scaling_adjustment
  adjustment_type        = var.adjustment_type
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.javahome_asg.name
}

resource "aws_autoscaling_policy" "RemoveInstancesPolicy" {
  name                   = var.remove_instances_policy
  scaling_adjustment     = var.remove_scaling_adjustment
  adjustment_type        = var.adjustment_type
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.javahome_asg.name
}

resource "aws_cloudwatch_metric_alarm" "avg_cpu_ge_80" {
  alarm_name          = var.scaling_up_alarm
  comparison_operator = var.scaling_up_comparison
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.scaling_up_threshold

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.javahome_asg.name
  }

  alarm_description = var.alarm_description
  alarm_actions     = [aws_autoscaling_policy.AddInstancesPolicy.arn]
}

resource "aws_cloudwatch_metric_alarm" "avg_cpu_le_30" {
  alarm_name          = var.scaling_down_alarm
  comparison_operator = var.scaling_down_comparison
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.scaling_down_threshold

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.javahome_asg.name
  }

  alarm_description = var.alarm_description
  alarm_actions     = [aws_autoscaling_policy.RemoveInstancesPolicy.arn]
}
