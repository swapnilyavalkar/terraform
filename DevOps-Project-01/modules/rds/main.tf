resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = var.tags
}

resource "aws_db_instance" "primary" {
  identifier             = var.primary_db_identifier
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = var.vpc_security_group_ids
  availability_zone      = var.availability_zone
  skip_final_snapshot    = var.skip_final_snapshot

  tags = var.tags
}

resource "aws_db_instance" "read_replica" {
  identifier             = var.read_replica_identifier
  engine                 = aws_db_instance.primary.engine
  engine_version         = aws_db_instance.primary.engine_version
  instance_class         = var.instance_class
  publicly_accessible    = var.publicly_accessible
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = var.vpc_security_group_ids
  availability_zone      = var.read_replica_availability_zone
  replicate_source_db    = aws_db_instance.primary.id
  skip_final_snapshot    = var.skip_final_snapshot

  tags = var.tags
}
