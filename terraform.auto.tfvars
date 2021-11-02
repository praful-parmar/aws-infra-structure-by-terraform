aws_region        = "us-east-1"


# these are used for tags
app_name        = "task"
app_environment = "production"

#vpc module
vpc_name= "vpc"
cidr_block= "10.0.0.0/22"
total_subnet= 6
public_subnet_count= 3
public_subnet_cidrs= ["10.0.0.0/25", "10.0.1.0/25", "10.0.2.0/25"]
private_subnet_count= 3
private_subnet_cidrs= ["10.0.0.128/25", "10.0.1.128/25", "10.0.2.128/25"]

#loadbalancing module
healthy_thresold= 3
unhealthy_threshold= 2
timeout= 4
interval= 5
tg_port= 80
tg_protocol= "HTTP"
listener_port= 80
listener_protocol= "HTTP"

#asg module
desired_capacity= 2
max_size= 5
min_size= 2

#database module
db_storage= 10
db_engine_version= "8.0.23"
db_instance_class= "db.t2.micro"
db_name= "db"
db_username= "admin"
db_password= "password"
db_identifier= "db"