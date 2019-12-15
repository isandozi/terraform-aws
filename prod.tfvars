# Variables TF file
vpc_cidr                      = "10.10.0.0/16"
region                        = "us-east-2"
nat_amis                      = { us-east-1 = "ami-0dacb0c129b49f529", us-east-2 = "ami-0dacb0c129b49f529" }
web_amis                      = { us-east-1 = "ami-0dacb0c129b49f529", us-east-2 = "ami-0dacb0c129b49f529" }
web_ec2_count                 = "2"
web_instance_type             = "t2.micro"
my_app_s3_bucket              = "imran-app-dev"
web_tags                      = "Webserver"
launch_configuration_name     = "web_lc"
launch_configuration_instance = "t2.micro"
autoscaling_group_name        = "javahome_asg"
autoscaling_min               = "1"
autoscaling_max               = "2"
health_check_grace_period     = "60"
health_check_type             = "ELB"
add_instances_policy          = "AddInstancesPolicy"
remove_instances_policy       = "RemoveInstancesPolicy"
add_scaling_adjustment        = "4"
remove_scaling_adjustment     = "-1"
adjustment_type               = "ChangeInCapacity"
cooldown                      = "60"
scaling_up_alarm              = "avg_cpu_ge_80"
scaling_down_alarm            = "avg_cpu_le_30"
scaling_up_comparison         = "GreaterThanOrEqualToThreshold"
scaling_down_comparison       = "LessThanOrEqualToThreshold"
evaluation_periods            = "2"
metric_name                   = "CPUUtilization"
namespace                     = "AWS/EC2"
period                        = "120"
statistic                     = "Average"
scaling_up_threshold          = "80"
scaling_down_threshold        = "30"
alarm_description             = "This metric monitors ec2 cpu utilization"
allocated_storage             = "20"
max_allocated_storage         = "50"
storage_type                  = "gp2"
engine                        = "mysql"
engine_version                = "5.7"
instance_class                = "db.t2.micro"
name                          = "javahome"
username                      = "javahome"
password                      = "Imran8347"
parameter_group_name          = "default.mysql5.7"
rds_subnet_name               = "javahome-rds"
rds_subnet_tags               = "Javahome DB subnet group"
rds_sg_name                   = "rds_sg"
rds_sg_description            = "Allow traffic for rds"
lb_tg_name                    = "javahome-lb-tg"
http_port                     = "80"
alb_name                      = "javahome-alb"
lb_type                       = "application"
alb_s3_logs                   = "imran-alb-s3-logs"
policy_id                     = "s3_lb_write"
prefix                        = "AWS-Logs"