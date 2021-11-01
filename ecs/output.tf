#ecs/output

output "aws_ecs_cluster_name" {
  value = aws_ecs_cluster.aws-ecs-cluster.name
}

output "aws_ecs_service_name" {
  value = aws_ecs_service.aws-ecs-service.name
}

output "ecs_cluster" {
  value = aws_ecs_cluster.aws-ecs-cluster
}