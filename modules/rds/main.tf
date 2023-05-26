# Create Database Subnet Group
# terraform aws db subnet group
resource "aws_db_subnet_group" "database-subnet-group" {
  name         = "database subnets"
  subnet_ids   = [var.private_data_subnet_az_01_id, var.private_data_subnet_az_01_id]
  description  = subnets for database instances

  tags   = {
    Name = "Database Subnets"
  }
}

# Get the Latest DB Snapshot
# terraform aws data db snapshot
data "aws_db_snapshot" "latest-db-snapshot" {
  db_snapshot_identifier = var.database_snapshot_identifier
  most_recent            = true
  snapshot_type          = "manual"
}

# Create Database Instance Restored from DB Snapshots
# terraform aws db instance
resource "aws_db_instance" "database-instance" {
  instance_class          = var.database_instance_class
  skip_final_snapshot     = true
  availability_zone       = 
  identifier              = 
  snapshot_identifier     = 
  db_subnet_group_name    = 
  multi_az                = 
  vpc_security_group_ids  = 
}