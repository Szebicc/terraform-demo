# DocumentDB Subnet Group
resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  name       = "docdb-private-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = var.project_name
  }
}

# Security Group for DocumentDB
resource "aws_security_group" "docdb_sg" {
  name        = "docdb-mongodb-sg"
  description = "Security group for DocumentDB MongoDB-compatible cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 27017 # MongoDB-compatible port
    to_port         = 27017
    protocol        = "tcp"
    cidr_blocks     = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.project_name
  }
}

# DocumentDB Cluster
resource "aws_docdb_cluster" "mongodb" {
  cluster_identifier      = "my-mongodb-db"
  engine                  = "docdb"
  engine_version          = "5.0.0" 
  master_username         = "mongoadmin"
  master_password         = "SecurePassword123!" # Use AWS Secrets Manager in production
  db_subnet_group_name    = aws_docdb_subnet_group.docdb_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.docdb_sg.id]
  storage_encrypted       = true
  backup_retention_period = 7
  preferred_backup_window = "03:00-04:00"
  preferred_maintenance_window = "Mon:04:00-Mon:05:00"
  deletion_protection     = false # Set to true in production
  skip_final_snapshot     = true # Remove or set to false in production

  tags = {
    Name = var.project_name
  }
}

# DocumentDB Cluster Instance
resource "aws_docdb_cluster_instance" "mongodb_instance" {
  count              = 3 # Multi-AZ equivalent (2 instances for high availability)
  identifier         = "my-mongodb-db-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.mongodb.cluster_identifier
  instance_class     = "db.t3.medium" # Matches RDS instance class

  # Enable Performance Insights (DocumentDB equivalent)
  # performance_insights_enabled = true

  # Enable auto minor version upgrades
  auto_minor_version_upgrade = true

  tags = {
    Name = var.project_name
  }
}

# IAM Role for DocumentDB Enhanced Monitoring
resource "aws_iam_role" "docdb_monitoring_role" {
  name = "docdb-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com" # DocumentDB uses same monitoring service
        }
      }
    ]
  })
}

# Attach Policy to Monitoring Role
resource "aws_iam_role_policy_attachment" "docdb_monitoring_policy" {
  role       = aws_iam_role.docdb_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
