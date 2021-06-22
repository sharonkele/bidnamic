#vpc resources
module "network" {
  source = "./modules/vpc-resources"
  region = var.region
  environment = var.environment_tag
}

#security group
module "security_group" {
  source = "./modules/security-group"
  region = var.region
  vpc_id = module.netowrk.vpc_id
  environment = var.environment_tag
}



#ec2 resources
module "ec2_instance" {
  source = "./modules/ec2-instance"
  image_id = var.image_id
  instance_type = var.instance_type 
  vpc_id = module.network.vpc_id
  security_group_id = [module.security_group.sg22, module.security_group.sg_80]
  
  tags = local.tags
/* 
  provisioner "remote-exec" {
    inline = [
      sudo yum update,
      sudo amazon-linux-extras install docker,
      sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)"-o /usr/local/bin/docker-compose,
      sudo usermod -aG docker $(whoami),
      sudo chmod +x /usr/local/bin/docker-compose,
      sudo yum install git,
      git clone https://github.com/sharonkele/bidnamic.git,
      docker-compose up -d --build
    ]
  
  }

*/


#rds resources
module "rds_database" {
  source = "./modules/database"
  allocated_storage    = 10
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  name                 = var.name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
}

}

