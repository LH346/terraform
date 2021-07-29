resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.WebProd.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }

}

resource "aws_lb" "test" {
  name               = "titlealb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.publicSubnet.id]
  subnets            = [aws_subnet.pubWebProd01.id, aws_subnet.pubWebProd02.id]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}


resource "aws_autoscaling_group" "web-asg" {
  name                 = "terraform-example-asg1"
  max_size             = 4
  min_size             = 2
  desired_capacity     = 2
  force_delete         = true
  launch_configuration = aws_launch_configuration.web-lc.name
  vpc_zone_identifier = [aws_subnet.privateWebProd01.id, aws_subnet.privateWebProd02.id]

  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = "true"
  }
  depends_on = [
    aws_lb.test
  ]
}


resource "aws_launch_configuration" "web-lc" {
  name          = "terraform-example-lc"
  image_id      = "ami-0dc2d3e4c0f9ebd18"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.lh346.key_name

  # Security group
  security_groups = [aws_security_group.privateSubnet.id]
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y && sudo yum install httpd -y && sudo systemctl start httpd
              EOF
}