#/ecs /main

resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "${var.app_name}-${var.app_environment}-cluster"
  tags = {
    Name        = "${var.app_name}-ecs"
    Environment = var.app_environment
  }
}

resource "aws_cloudwatch_log_group" "log-group" {
  name = "${var.app_name}-${var.app_environment}-logs"

  tags = {
    Application = var.app_name
    Environment = var.app_environment
  }
}

# "image": "${aws_ecr_repository.aws-ecr.repository_url}:latest",



resource "aws_ecs_task_definition" "task_definition" {
  container_definitions    =<<DEFINITION
  [
    {
      "name": "${var.app_name}-${var.app_environment}-container",
      "image": "nginx:latest", 
      "portMappings": [
        {
          "hostPort": 80,
          "containerPort": 80
        }
      ],
      "cpu": 256,
      "memory": 512
    }
  ]
  DEFINITION       
      # "networkMode": "awsvpc"
                                 
  execution_role_arn       = var.execution_role_arn                                                                    
  family                   = "${var.app_name}-task"                                                                     
#  network_mode             = "awsvpc"                                                                                     
  memory                   = "512"
  cpu                      = "256"
  requires_compatibilities = ["EC2"]                                                                                       
  task_role_arn            = var.task_role_arn                                                                      
  tags = {
    Name        = "${var.app_name}-ecs-td"
    Environment = var.app_environment
  }
} 

# data "aws_ecs_task_definition" "main" {
#   task_definition = aws_ecs_task_definition.aws-ecs-task.family
# }


resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "${var.app_name}-${var.app_environment}-ecs-service"
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = "${aws_ecs_task_definition.task_definition.family}"
  launch_type          = "EC2"
  desired_count        = 1
  force_new_deployment = true


  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${var.app_name}-${var.app_environment}-container"
    container_port   = 80
  }

  depends_on = [var.depends_on_aws_ecs_service]
}