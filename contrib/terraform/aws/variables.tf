variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Key"
}

variable "AWS_SSH_KEY_NAME" {
  description = "Name of the SSH keypair to use in AWS."
}

variable "AWS_SSH_KEY_FILE" {
  description = "Local SSH keyfile to access AWS instances."
}

variable "AWS_DEFAULT_REGION" {
  description = "AWS Region"
}

//General Cluster Settings

variable "aws_cluster_name" {
  description = "Name of AWS Cluster"
}

variable "ssh_user" {
    description = "Name of SSH user to run remote commands."
}

//AWS VPC Variables

variable "aws_vpc_cidr_block" {
  description = "CIDR Block for VPC"
}

variable "aws_avail_zones" {
  description = "Availability Zones Used"
  type = "list"
}

variable "aws_cidr_subnets_private" {
  description = "CIDR Blocks for private subnets in Availability Zones"
  type = "list"
}

variable "aws_cidr_subnets_public" {
  description = "CIDR Blocks for public subnets in Availability Zones"
  type = "list"
}

//AWS EC2 Settings

variable "aws_bastion_ami" {
    description = "AMI ID for Bastion Host in chosen AWS Region"
}

variable "aws_bastion_size" {
    description = "EC2 Instance Size of Bastion Host"
}

/*
* AWS EC2 Settings
* The number should be divisable by the number of used
* AWS Availability Zones without an remainder.
*/
variable "aws_fusion_api_num" {
    description = "Number of Fusion API nodes"
}

variable "aws_fusion_api_size" {
    description = "Instance size of Fusion API nodes"
}

variable "aws_fusion_api_ami" {
    description = "AMI ID for Fusion API nodes"
}

variable "aws_fusion_indexer_num" {
    description = "Number of Fusion Indexer nodes"
}

variable "aws_fusion_indexer_size" {
    description = "Instance size of Fusion Indexer nodes"
}

variable "aws_fusion_indexer_ami" {
    description = "AMI ID for Fusion Indexer nodes"
}

variable "aws_fusion_solr_num" {
    description = "Number of Fusion Solr nodes"
}

variable "aws_fusion_solr_size" {
    description = "Instance size of Fusion Solr nodes"
}

variable "aws_fusion_solr_ami" {
    description = "AMI ID for Fusion Solr nodes"
}

variable "aws_fusion_zookeeper_num" {
    description = "Number of Fusion ZooKeeper nodes"
}

variable "aws_fusion_zookeeper_size" {
    description = "Instance size of Fusion ZooKeeper nodes"
}

variable "aws_fusion_zookeeper_ami" {
    description = "AMI ID for Fusion ZooKeeper nodes"
}

/*
* AWS ELB Settings
*
*/
variable "aws_elb_api_port" {
    description = "Port for AWS ELB"
}

variable "fusion_secure_api_port" {
    description = "Secure Port of Fusion API Server"
}
