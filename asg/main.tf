#asg/main

resource "aws_launch_template" "launch_template" {
  name_prefix            = "launch_template"
  image_id               = "ami-02e136e904f3da870"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.vpc_security_group_ids]
  user_data              = var.userdata_path

  depends_on = [
  var.ecs_cluster
  ]

  iam_instance_profile {
    name = var.iam_instance_profile
  }
}


resource "aws_autoscaling_group" "asg" {
  name                      = "asg"
  vpc_zone_identifier = var.vpc_zone_identifier
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  target_group_arns   = [var.target_group_arns]
  protect_from_scale_in =true

  lifecycle {
    create_before_destroy = true
  }
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
}
