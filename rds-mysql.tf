resource "aws_db_instance" "javahome" {
  identifier                 = "javahome-${terraform.workspace}"
  allocated_storage          = var.allocated_storage
  max_allocated_storage      = var.max_allocated_storage
  storage_type               = var.storage_type
  engine                     = var.engine
  engine_version             = var.engine_version
  instance_class             = var.instance_class
  name                       = var.name
  username                   = var.username
  password                   = var.password
  parameter_group_name       = var.parameter_group_name
  db_subnet_group_name       = aws_db_subnet_group.javahome.id
  backup_window              = "01:00-01:30"
  auto_minor_version_upgrade = false
  skip_final_snapshot        = true
  final_snapshot_identifier  = "imran-practice-rds"
}

resource "aws_db_subnet_group" "javahome" {
  name       = var.rds_subnet_name
  subnet_ids = aws_subnet.private.*.id

  tags = {
    Name = var.rds_subnet_tags
  }
}

resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  description = var.rds_sg_name
  vpc_id      = aws_vpc.my_app.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
