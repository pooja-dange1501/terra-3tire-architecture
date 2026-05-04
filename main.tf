provider "aws" {
  region = var.myregion
}

# ---------------- VPC MODULE ----------------
module "vpc" {
  source = "./modules/vpc"
}

# ---------------- EC2 MODULE ----------------
module "ec2" {
  source = "./modules/ec2"

  rds_endpoint = module.rds.endpoint
  ami           = var.myami        # ✔ correct
  instance_type = var.ins_type  

  web_subnet_id = module.vpc.web_subnet
  app_subnet_id = module.vpc.app_subnet

  web_sg        = module.vpc.web_sg
  app_sg        = module.vpc.app_sg
  
}
# ---------------- RDS MODULE ----------------
module "rds" {
  source = "./modules/rds"

  db_subnet_ids = [
    module.vpc.app_subnet,
    module.vpc.db_subnet
  ]

  db_sg          = module.vpc.db_sg
  db_password    = var.db_password
}

output "web_public_ip" {
  value = module.ec2.web_public_ip
}

output "app_private_ip" {
  value = module.ec2.app_private_ip
}