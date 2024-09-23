# Security Group for CI Instance
resource "aws_security_group" "ci_security_group" {
  vpc_id      = aws_vpc.vpc.id
  description = "Allowing access to CI tools (Jenkins, SonarQube, Splunk, Prometheus, Grafana)"

  ingress = [
    for port in [22, 8080, 9000, 9090, 80, 3000] : {
      description      = "Access to CI tools"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.sg-name}-ci"
  }
}

# Security Group for CD Instance
resource "aws_security_group" "cd_security_group" {
  vpc_id      = aws_vpc.vpc.id
  description = "Allowing access to CD tools (ArgoCD, Kubernetes)"

  ingress = [
    for port in [22, 80, 443, 8080] : {
      description      = "Access to CD tools"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.sg-name}-cd"
  }
}
