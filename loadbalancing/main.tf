# loadbalancing/main


resource "aws_lb" "alb" {
  name            = "lb"
  security_groups = [var.security_groups]
  subnets         = var.subnets
  idle_timeout    = 400
}


resource "aws_lb_target_group" "tg" {
  name     = "lb-tg"
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id
  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
  health_check {
    healthy_threshold   = var.healthy_thresold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
  }
}


resource "aws_lb_listener" "lb_listerner" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.id
  }
}
