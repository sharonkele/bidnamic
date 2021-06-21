resource "aws_instance" "instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id = var.subnet_public_id
  vpc_security_group_ids = ["${var.security_group_ids}"]
  key_name = "${var.key_pair_name}"
  tags {
    Environment = var.environment_tag
  }
}
resource "aws_eip" "testInstanceEip" {
  vpc       = true
  instance  = aws_instance.instance.id
  tags = local.tags
  
}


resource "aws_iam_role" "ec2_role" {
  name = "flask-app-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tags
  
}
}

resource "aws_iam_policy" "flask_ec2" {
  
}