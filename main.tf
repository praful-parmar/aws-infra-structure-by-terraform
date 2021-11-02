# root/main.tf 

module "vpc" {
  source               = "./vpc"
  vpc_name             = var.vpc_name
  cidr_block           = var.cidr_block
  total_subnet         = var.total_subnet
  public_subnet_count  = var.public_subnet_count
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_count = var.private_subnet_count
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id
  app_name=var.app_name
  app_environment=var.app_environment
}

module "loadbalancing" {
  source              = "./loadbalancing"
  vpc_id              = module.vpc.vpc_id
  security_groups     = module.sg.alb_sg
  subnets             = module.vpc.public_subnet_id
  healthy_thresold    = var.healthy_thresold
  unhealthy_threshold = var.unhealthy_threshold
  timeout             = var.timeout
  interval            = var.interval
  tg_port             = var.tg_port
  tg_protocol         = var.tg_protocol
  listener_port       = var.listener_port
  listener_protocol   = var.listener_protocol
}

module "ecs" {
  source           = "./ecs"
  app_name= var.app_name
  app_environment= var.app_environment
  aws_region= var.aws_region
  execution_role_arn= module.iam.execution_role_arn
  task_role_arn= module.iam.task_role_arn
  subnets          = module.vpc.public_subnet_id
  security_groups  = [
      module.sg.service_security_group,
      module.sg.load_balancer_security_group
    ]
  target_group_arn = module.loadbalancing.target_gp_arn 
  depends_on_aws_ecs_service= module.loadbalancing.aws_lb_listener
}

module "asg" {
  source                 = "./asg"
  vpc_security_group_ids = module.sg.vm_sg
  userdata_path          = filebase64("./userdata.sh")
  vpc_zone_identifier    = module.vpc.private_subnet_id
  desired_capacity       = var.desired_capacity
  max_size               = var.max_size
  min_size               = var.min_size
  target_group_arns      = module.loadbalancing.target_gp_arn
  iam_instance_profile = module.iam.iam_instance_profile
  ecs_cluster = module.ecs.ecs_cluster
 
}

module "iam" {
  source = "./iam"
}


module "database" {
  source                 = "./database"
  db_storage             = var.db_storage
  db_engine_version      = var.db_engine_version
  db_instance_class      = var.db_instance_class
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  db_subnet_group_name   = module.vpc.db_subnet[0]
  vpc_security_group_ids = [module.sg.db_security_group]
  db_identifier          = var.db_identifier
  skip_final_snapshot    = true
}




# yum update -y
# yum install httpd -y
# systemctl start httpd
# systemctl enable httpd
# echo "<h1>$(hostname -f) -me" > /var/www/html/index.html