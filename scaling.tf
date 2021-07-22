//resource "aws_autoscaling_group" "scaling" {
//    
//}

resource "aws_launch_template" "prodPrivate" {
    associate_public_ip_address = false
    image_id = ami-0dc2d3e4c0f9ebd18
  
}