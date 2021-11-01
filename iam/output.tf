output "execution_role_arn" {
  value = aws_iam_role.ecs-service-role.arn
}

output "task_role_arn" {
  value =   aws_iam_role.ecs-service-role.arn
}

output "iam_instance_profile"{
  value=aws_iam_instance_profile.ecs-instance-profile.name
}


output "ecs_instance_role" {
  value = aws_iam_role.ecs-instance-role.arn
}
