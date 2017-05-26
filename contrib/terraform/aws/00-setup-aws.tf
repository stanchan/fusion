terraform {
    required_version = ">= 0.9.5"
}

provider "aws" {
    access_key = "${var.AWS_ACCESS_KEY_ID}"
    secret_key = "${var.AWS_SECRET_ACCESS_KEY}"
    region = "${var.AWS_DEFAULT_REGION}"
}

/*
* Calling modules who create the initial AWS VPC / AWS ELB
* and AWS IAM Roles for Fusion Deployment
*/

module "aws-vpc" {
  source = "modules/vpc"

  aws_cluster_name = "${var.aws_cluster_name}"
  aws_vpc_cidr_block = "${var.aws_vpc_cidr_block}"
  aws_avail_zones="${var.aws_avail_zones}"

  aws_cidr_subnets_private="${var.aws_cidr_subnets_private}"
  aws_cidr_subnets_public="${var.aws_cidr_subnets_public}"

}

module "aws-elb" {
  source = "modules/elb"

  aws_cluster_name="${var.aws_cluster_name}"
  aws_vpc_id="${module.aws-vpc.aws_vpc_id}"
  aws_avail_zones="${var.aws_avail_zones}"
  aws_subnet_ids_public="${module.aws-vpc.aws_subnet_ids_public}"
  aws_elb_api_port = "${var.aws_elb_api_port}"
  fusion_secure_api_port = "${var.fusion_secure_api_port}"

}

module "aws-iam" {
  source = "modules/iam"

  aws_cluster_name="${var.aws_cluster_name}"
}
