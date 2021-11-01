#!/bin/bash
yum update -y  
amazon-linux-extras disable docker  
amazon-linux-extras install -y ecs 
echo ECS_CLUSTER=task-production-cluster >> /etc/ecs/ecs.config 
systemctl enable --now --no-block  ecs 
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<h1>$(hostname -f) -me" > /var/www/html/index.html