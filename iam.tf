resource "aws_iam_role" "iam-role" {
  name = var.iam-role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "${var.iam-role}-profile"
  role = aws_iam_role.iam-role.name
}
