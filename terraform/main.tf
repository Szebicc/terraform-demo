module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  region = var.region
}

module "db" {
  source = "./modules/db"

  tag_name = var.project_name

  vpc_id = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
  subnet_ids = module.vpc.private_db_subnet_ids
  project_name = var.project_name
}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  profile = var.profile
  region = var.region
}

module "eks" {
  source = "./modules/eks"

  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  aws_profile = var.profile
  aws_region = var.region
  configure_kubectl = true
}


