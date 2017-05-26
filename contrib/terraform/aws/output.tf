output "bastion_ip" {
    value = "${join("\n", aws_instance.bastion-server.*.public_ip)}"
}

output "api" {
    value = "${join("\n", aws_instance.fusion-api.*.private_ip)}"
}

output "indexer" {
    value = "${join("\n", aws_instance.fusion-indexer.*.private_ip)}"
}

output "solr" {
    value = "${join("\n", aws_instance.fusion-solr.*.private_ip)}"
}

output "zookeeper" {
    value = "${join("\n", aws_instance.fusion-zookeeper.*.private_ip)}"
}

output "aws_elb_api_fqdn" {
    value = "${module.aws-elb.aws_elb_api_fqdn}:${var.aws_elb_api_port}"
}

output "inventory" {
    value = "${data.template_file.inventory.rendered}"
}