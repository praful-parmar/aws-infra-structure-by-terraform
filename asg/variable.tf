#asg/variable

variable "vpc_security_group_ids" {}
variable "userdata_path" {}
variable "vpc_zone_identifier" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
variable "target_group_arns" {}
variable "iam_instance_profile"{}


variable "ecs_cluster" {
  
}