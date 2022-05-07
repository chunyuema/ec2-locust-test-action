resource "aws_security_group" "this" {
  name        = var.name
  description = "Allow all traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
  }
}

resource "aws_iam_role" "this" {
  name = var.name
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
}

resource "aws_iam_instance_profile" "this" {
  name = var.name
  role = aws_iam_role.this.name
}

resource "aws_spot_instance_request" "this" {
  ami                    = var.ami != null ? var.ami : data.aws_ami.amazon-2.id
  instance_type          = var.instance_type
  key_name               = var.key_name != "null" ? var.key_name : null
  subnet_id              = data.aws_subnet.default.id
  user_data              = data.template_file.userdata.rendered
  iam_instance_profile   = aws_iam_instance_profile.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  valid_until                          = timeadd(local.timestamp, "1h")
  wait_for_fulfillment                 = var.wait_for_fulfillment
  spot_type                            = var.spot_type
  instance_interruption_behavior       = "terminate"
  instance_initiated_shutdown_behavior = "terminate"

  tags = {
    Name = "Wolf Load Test Dev"
  }
}


# ami                    = var.ami != null ? var.ami : data.aws_ami.ubuntu.id
