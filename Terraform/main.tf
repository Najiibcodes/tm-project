provider "aws" {
  region = "eu-west-2"
}


terraform {
  backend "s3" {
    bucket = "threat-model-bucket-delta"      # Your S3 bucket name
    key    = "ecs-delta-project/terraform/terraform.tfstate"  # Key path within the bucket
    region = "eu-west-2"
    encrypt = true
  }
}



module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

# Subnets
module "subnets" {
  source       = "./modules/subnets"
  vpc_id       = module.vpc.vpc_id
  subnet1_cidr = var.subnet1_cidr
  subnet2_cidr = var.subnet2_cidr
}


module "ecs_cluster" {
  source           = "./modules/ecs_cluster"
  ecs_cluster_name = var.ecs_cluster_name
}

module "alb" {
  source                  = "./modules/alb"
  alb_name                = var.alb_name
  security_group_id       = module.security_group.security_group_id
  subnet_ids              = module.subnets.subnet_ids
  enable_deletion_protection = var.enable_deletion_protection
  environment             = var.environment
  certificate_arn         = module.acm.certificate_arn # Reference ACM cert ARN
  target_group_name       = "my-app-tg"
  target_port             = var.container_port
  vpc_id                  = module.vpc.vpc_id
}


module "security_group" {
  source         = "./modules/security_group"
  vpc_id         = module.vpc.vpc_id
  container_port = var.container_port
}


module "network" {
  source     = "./modules/network"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.subnets.subnet_ids
}


module "route53" {
  source                    = "./modules/route53"
  domain_name               = "najiib.co.uk"
  subdomain_name            = "www.najiib.co.uk"
  alb_dns_name              = module.alb.alb_dns_name
  alb_zone_id               = module.alb.alb_zone_id
  domain_validation_options = module.acm.domain_validation_options
  zone_id                   = aws_route53_zone.najiib.zone_id
}




# ACM Certificate for najiib.co.uk
module "acm" {
  source      = "./modules/acm"
  domain_name = "najiib.co.uk"
  environment = var.environment
}

