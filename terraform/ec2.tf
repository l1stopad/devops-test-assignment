resource "aws_instance" "wordpress" {
  ami                    = "ami-006cfe9f763a1cb77"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
 # iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name # Повертаємо доступ до SSM

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2 php php-mysql amazon-ssm-agent
    sudo systemctl enable apache2
    sudo systemctl start apache2
    sudo systemctl enable amazon-ssm-agent
    sudo systemctl start amazon-ssm-agent
  EOF

  tags = {
    Name = "WordPress Server"
  }
}
