variable "vpc_cidr" {}
variable "region" {}
variable "nat_amis" {}
variable "web_amis" {}
variable "web_ec2_count" {}
variable "web_instance_type" {}
variable "my_app_s3_bucket" {}
variable "web_tags" {}
variable "launch_configuration_name" {}
variable "launch_configuration_instance" {}
variable "autoscaling_group_name" {}
variable "autoscaling_min" {}
variable "autoscaling_max" {}
variable "health_check_grace_period" {}
variable "health_check_type" {}
variable "add_instances_policy" {}
variable "remove_instances_policy" {}
variable "add_scaling_adjustment" {}
variable "remove_scaling_adjustment" {}
variable "adjustment_type" {}
variable "cooldown" {}
variable "scaling_up_alarm" {}
variable "scaling_down_alarm" {}
variable "scaling_up_comparison" {}
variable "scaling_down_comparison" {}
variable "evaluation_periods" {}
variable "metric_name" {}
variable "namespace" {}
variable "period" {}
variable "statistic" {}
variable "scaling_up_threshold" {}
variable "scaling_down_threshold" {}
variable "alarm_description" {}
variable "allocated_storage" {}
variable "storage_type" {}
variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "name" {}
variable "username" {}
variable "password" {}
variable "parameter_group_name" {}
variable "rds_subnet_name" {}
variable "rds_subnet_tags" {}
variable "rds_sg_name" {}
variable "rds_sg_description" {}
variable "max_allocated_storage" {}
variable "lb_tg_name" {}
variable "http_port" {}
variable "alb_name" {}
variable "lb_type" {}
variable "alb_s3_logs" {}
variable "policy_id" {}
variable "prefix" {}
