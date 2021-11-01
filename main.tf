# root/main.tf 

module "vpc" {
  source               = "./vpc"
  vpc_name             = "vpc"
  cidr_block           = "10.0.0.0/22"
  total_subnet         = 6
  public_subnet_count  = 3
  public_subnet_cidrs  = ["10.0.0.0/25", "10.0.1.0/25", "10.0.2.0/25"]
  private_subnet_count = 3
  private_subnet_cidrs = ["10.0.0.128/25", "10.0.1.128/25", "10.0.2.128/25"]
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
  healthy_thresold    = 3
  unhealthy_threshold = 2
  timeout             = 4
  interval            = 5
  tg_port             = 80
  tg_protocol         = "HTTP"
  listener_port       = 80
  listener_protocol   = "HTTP"
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
  desired_capacity       = 2
  max_size               = 5
  min_size               = 2
  target_group_arns      = module.loadbalancing.target_gp_arn
  iam_instance_profile = module.iam.iam_instance_profile
  ecs_cluster = module.ecs.ecs_cluster
 
}

module "iam" {
  source = "./iam"
}


module "database" {
  source                 = "./database"
  db_storage             = 10
  db_engine_version      = "8.0.23"
  db_instance_class      = "db.t2.micro"
  db_name                = "db"
  db_username            = "admin"
  db_password            = "password"
  db_subnet_group_name   = module.vpc.db_subnet[0]
  vpc_security_group_ids = [module.sg.db_security_group]
  db_identifier          = "db"
  skip_final_snapshot    = true
}