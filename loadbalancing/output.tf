# loadbalancing/output

output "target_gp_arn" {
  value = aws_lb_target_group.tg.arn
}

output "aws_lb_listener" {
  value = aws_lb_listener.lb_listerner
}