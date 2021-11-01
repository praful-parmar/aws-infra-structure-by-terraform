#loadabalancing/variable

variable "security_groups" {}
variable "subnets" {}
variable "vpc_id" {}
variable "healthy_thresold" {}
variable "unhealthy_threshold" {}
variable "timeout" {}
variable "interval" {}

variable "tg_port" {}
variable "tg_protocol" {}
variable "listener_port" {}
variable "listener_protocol" {}

