#ecs / variable

variable "app_name" {}
variable "app_environment" {}
variable "aws_region" {}
variable "execution_role_arn" {}
variable "task_role_arn" {}
variable "subnets" {}
variable "security_groups" {}
variable "target_group_arn" {}
variable "depends_on_aws_ecs_service" {}


