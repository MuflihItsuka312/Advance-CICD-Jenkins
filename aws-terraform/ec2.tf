# CI EC2 Instance
resource "aws_instance" "ci_instance" {
  ami                    = data.aws_ami.ami.id
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.ci_security_group.id]
  key_name               = var.key-name
  iam_instance_profile   = var.iam-role

  tags = {
    Name = var.ci-instance-name
  }
}

# CD EC2 Instance
resource "aws_instance" "cd_instance" {
  ami                    = data.aws_ami.ami.id
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.cd_security_group.id]
  key_name               = var.key-name
  iam_instance_profile   = var.iam-role

  tags = {
    Name = var.cd-instance-name
  }
}
