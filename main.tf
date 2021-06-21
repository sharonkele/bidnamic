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
  
  tags  {
    var.environment_tag

  }
  user_data = <<EOF 


}

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

