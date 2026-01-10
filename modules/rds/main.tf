resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnets"
  subnet_ids = var.private_subnet_ids
  tags       = { Name = "${var.project_name}-db-subnets" }
}

resource "aws_security_group" "rds_sg" {
  name   = "${var.project_name}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    description     = "ECS to RDS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_sg_id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = var.db_password_secret_name
}

resource "aws_db_instance" "this" {
  identifier                    = "${var.project_name}-postgres"
  engine                        = var.db_engine
  engine_version                = "14"
  instance_class                = var.db_instance_class
  allocated_storage             = 20
  max_allocated_storage         = 100
  db_name                       = var.db_name
  username                      = var.db_username
  password                      = data.aws_secretsmanager_secret_version.db_password.secret_string
  db_subnet_group_name          = aws_db_subnet_group.this.name
  vpc_security_group_ids        = [aws_security_group.rds_sg.id]
  multi_az                      = true
  publicly_accessible           = false
  backup_retention_period       = 7
  deletion_protection           = true
  storage_encrypted             = true
  monitoring_interval           = 60
  performance_insights_enabled  = true
  tags = { Name = "${var.project_name}-rds" }
}