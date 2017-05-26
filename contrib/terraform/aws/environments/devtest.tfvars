#Global Vars
aws_cluster_name = "devtest"
ssh_user = "ubuntu"

#VPC Vars
aws_vpc_cidr_block = "10.10.192.0/18"
aws_cidr_subnets_private = ["10.10.192.0/20","10.10.208.0/20"]
aws_cidr_subnets_public = ["10.10.224.0/20","10.10.240.0/20"]
aws_avail_zones = ["us-west-2a","us-west-2b"]

#Bastion Host
aws_bastion_ami = "ami-efd0428f"
aws_bastion_size = "t2.small"
aws_key_pair="schan3"

#fusion Cluster
aws_fusion_api_num = 3
aws_fusion_api_size = "t2.small"
aws_fusion_api_ami = "ami-221ea342"
aws_fusion_indexer_num = 4
aws_fusion_indexer_size = "t2.small"
aws_fusion_indexer_ami = "ami-221ea342"
aws_fusion_solr_num = 4
aws_fusion_solr_size = "t2.small"
aws_fusion_solr_ami = "ami-221ea342"
aws_fusion_zookeeper_num = 5
aws_fusion_zookeeper_size = "t2.small"
aws_fusion_zookeeper_ami = "ami-221ea342"

#Settings AWS ELB
aws_elb_api_port = 8764
fusion_secure_api_port = 8764
