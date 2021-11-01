# sg/output

output "alb_sg" {
  value = aws_security_group.alb.id
}

output "vm_sg" {
  value = aws_security_group.vm.id
}

output "service_security_group" {
  value = aws_security_group.service_security_group.id
}

output "load_balancer_security_group" {
  value = aws_security_group.alb.id
}

output "db_security_group" {
  value= aws_security_group.db_security_group.id
}