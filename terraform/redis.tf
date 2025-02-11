# Група підмереж для Redis
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id] # Використовуємо 2 приватні підмережі

  tags = {
    Name = "Redis Subnet Group"
  }
}

# Security Group для Redis
resource "aws_security_group" "redis_sg" {
  vpc_id = aws_vpc.main.id

  # Дозволяємо доступ тільки з EC2
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id] # Дозволяємо трафік тільки з EC2
  }

  # Дозволяємо вихідний трафік (щоб Redis міг підключатися до AWS API)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Redis Security Group"
  }
}

# ElastiCache Redis у приватній підмережі
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "wordpress-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  security_group_ids   = [aws_security_group.redis_sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name # Використовуємо правильну Subnet Group

  tags = {
    Name = "WordPress Redis Cluster"
  }
}
