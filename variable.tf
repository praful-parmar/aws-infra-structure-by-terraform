variable "app_name" {}
variable "app_environment" {}
variable "aws_region" {}

#vpc module
variable "vpc_name" {}
variable "cidr_block" {}
variable "total_subnet" {}
variable "public_subnet_count" {}
variable "public_subnet_cidrs" {}
variable "private_subnet_count" {}
variable "private_subnet_cidrs" {}

#loadbalancing module
variable "healthy_thresold" {}
variable "unhealthy_threshold" {}
variable "timeout" {}
variable "interval" {}
variable "tg_port" {}
variable "tg_protocol" {}
variable "listener_port" {}
variable "listener_protocol" {}


#asg module
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}


#database module
variable "db_storage" {}
variable "db_engine_version" {}
variable "db_instance_class" {}
variable "db_name" {
    sensitive = true
}
variable "db_username" {
    sensitive = true
}
variable "db_password" {
    sensitive = true
}
variable "db_identifier" {
    sensitive = true
}