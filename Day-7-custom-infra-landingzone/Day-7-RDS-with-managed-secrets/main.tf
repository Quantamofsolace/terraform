resource "aws_db_instance" "default" {
  allocated_storage       = 10
  db_name                 = "mydb"
  identifier              = "rds-test"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"

  manage_master_user_password = true

  db_subnet_group_name    = aws_db_subnet_group.sub-grp.id
  parameter_group_name    = "default.mysql8.0"

  # Backup settings
  backup_retention_period = 7
  backup_window           = "02:00-03:00"

  maintenance_window      = "sun:04:00-sun:05:00"

  deletion_protection     = true

  skip_final_snapshot     = true

  depends_on = [aws_db_subnet_group.sub-grp]
}


############################################
# READ REPLICA
############################################

resource "aws_db_instance" "read_replica" {

  identifier            = "rds-test-replica"
  replicate_source_db   = aws_db_instance.default.id

  instance_class        = "db.t3.micro"

  db_subnet_group_name  = aws_db_subnet_group.sub-grp.id

  publicly_accessible   = false

  skip_final_snapshot   = true

  depends_on = [aws_db_instance.default]
}



############################################
# NETWORK
############################################

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1b"
}

resource "aws_db_subnet_group" "sub-grp" {
  name       = "mycutsubnett"
  subnet_ids = [
    aws_subnet.subnet-1.id,
    aws_subnet.subnet-2.id
  ]

  tags = {
    Name = "My DB subnet group"
  }
}