terraform {
    required_version = ">= 0.9.5"
}

/*
* Create Fusion nodes and zookeeper instances
*
*/

resource "aws_instance" "fusion-api" {
    ami = "${var.aws_fusion_api_ami}"
    instance_type = "${var.aws_fusion_api_size}"

    count = "${var.aws_fusion_api_num}"

    availability_zone  = "${element(var.aws_avail_zones,count.index)}"
    subnet_id = "${element(module.aws-vpc.aws_subnet_ids_private,count.index)}"

    vpc_security_group_ids = [ "${module.aws-vpc.aws_security_group}" ]

    iam_instance_profile = "${module.aws-iam.fusion-api-profile}"
    key_name = "${var.AWS_SSH_KEY_NAME}"

    tags {
        Name = "fusion-${var.aws_cluster_name}-api${count.index}"
        Cluster = "${var.aws_cluster_name}"
        Role = "fusion_ui_api"
    }
}

resource "aws_elb_attachment" "attach_fusion_api_nodes" {
  count = "${var.aws_fusion_api_num}"
  elb      = "${module.aws-elb.aws_elb_api_id}"
  instance = "${element(aws_instance.fusion-api.*.id,count.index)}"
}

resource "aws_instance" "fusion-indexer" {
    ami = "${var.aws_fusion_indexer_ami}"
    instance_type = "${var.aws_fusion_indexer_size}"

    count = "${var.aws_fusion_indexer_num}"

    availability_zone  = "${element(var.aws_avail_zones,count.index)}"
    subnet_id = "${element(module.aws-vpc.aws_subnet_ids_private,count.index)}"

    vpc_security_group_ids = [ "${module.aws-vpc.aws_security_group}" ]

    iam_instance_profile = "${module.aws-iam.fusion-indexer-profile}"
    key_name = "${var.AWS_SSH_KEY_NAME}"

    tags {
        Name = "fusion-${var.aws_cluster_name}-indexer${count.index}"
        Cluster = "${var.aws_cluster_name}"
        Role = "fusion_indexer"
    }
}

resource "aws_instance" "fusion-solr" {
    ami = "${var.aws_fusion_solr_ami}"
    instance_type = "${var.aws_fusion_solr_size}"

    count = "${var.aws_fusion_solr_num}"

    availability_zone  = "${element(var.aws_avail_zones,count.index)}"
    subnet_id = "${element(module.aws-vpc.aws_subnet_ids_private,count.index)}"

    vpc_security_group_ids = [ "${module.aws-vpc.aws_security_group}" ]

    iam_instance_profile = "${module.aws-iam.fusion-solr-profile}"
    key_name = "${var.AWS_SSH_KEY_NAME}"

    tags {
        Name = "fusion-${var.aws_cluster_name}-solr${count.index}"
        Cluster = "${var.aws_cluster_name}"
        Role = "fusion_solr"
    }
}

resource "aws_instance" "fusion-zookeeper" {
    ami = "${var.aws_fusion_zookeeper_ami}"
    instance_type = "${var.aws_fusion_zookeeper_size}"

    count = "${var.aws_fusion_zookeeper_num}"

    availability_zone = "${element(var.aws_avail_zones,count.index)}"
    subnet_id = "${element(module.aws-vpc.aws_subnet_ids_private,count.index)}"

    vpc_security_group_ids = [ "${module.aws-vpc.aws_security_group}" ]

    key_name = "${var.AWS_SSH_KEY_NAME}"

    tags {
        Name = "fusion-${var.aws_cluster_name}-zookeeper${count.index}"
        Cluster = "${var.aws_cluster_name}"
        Role = "fusion_zookeeper"
        Index = "${count.index}"
    }
}
