#!/bin/bash
yum update -y  
amazon-linux-extras disable docker  
amazon-linux-extras install -y ecs 
echo ECS_CLUSTER=task-production-cluster >> /etc/ecs/ecs.config 
systemctl enable --now --no-block  ecs 