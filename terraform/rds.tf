# Група підмереж для RDS (повинна мати 2 підмережі)
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id] # Використовуємо обидві приватні підмережі

  tags = {
    Name = "RDS Subnet Group"
  }
}

# RDS у приватних підмережах
resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = 20
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  db_name            = "wordpress"
  username          = "admin"
  password          = "password123"
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot   = true
  db_subnet_group_name  = aws_db_subnet_group.rds_subnet_group.name # Використовуємо правильну Subnet Group
}


