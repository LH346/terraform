resource "aws_elb" "web-elb" {
  name = "terraform-example-elb"

  # The same availability zone as our instances
 // availability_zones = ["us-east-1a", "us-east-1b"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  subnets = [aws_subnet.privateWebProd01.id, aws_subnet.privateWebProd02.id]
}


resource "aws_autoscaling_group" "web-asg" {
 // availability_zones   = ["us-east-1a", "us-east-1b"]
  name                 = "terraform-example-asg"
  max_size             = 4
  min_size             = 2
  desired_capacity     = 2
  force_delete         = true
  launch_configuration = aws_launch_configuration.web-lc.name
  load_balancers       = [aws_elb.web-elb.name]
  vpc_zone_identifier = [aws_subnet.privateWebProd01.id, aws_subnet.privateWebProd02.id]

  #vpc_zone_identifier = ["${split(",", var.availability_zones)}"]
  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = "true"
  }
}


resource "aws_launch_configuration" "web-lc" {
  name          = "terraform-example-lc"
  image_id      = "ami-0dc2d3e4c0f9ebd18"
  instance_type = "t2.micro"

  # Security group
  security_groups = [aws_security_group.privateSubnet.id]
}