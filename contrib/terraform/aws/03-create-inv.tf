terraform {
    required_version = ">= 0.9.5"
}

/*
* Create Fusion Inventory File
*
*/
data "template_file" "inventory" {
    template = "${file("${path.module}/templates/inventory.tpl")}"

    vars {
        public_ip_address_bastion = "${join("\n",formatlist("%s ansible_ssh_host=%s ansible_user=ubuntu ansible_become=true" , aws_instance.bastion-server.*.tags.Name, aws_instance.bastion-server.*.public_ip))}"
        connection_strings_fusion_api = "${join("\n",formatlist("%s ansible_ssh_host=%s ansible_user=admin ansible_become=true", aws_instance.fusion-api.*.tags.Name, aws_instance.fusion-api.*.private_ip))}"
        connection_strings_fusion_indexer = "${join("\n", formatlist("%s ansible_ssh_host=%s ansible_user=admin ansible_become=true", aws_instance.fusion-indexer.*.tags.Name, aws_instance.fusion-indexer.*.private_ip))}"
        connection_strings_fusion_solr = "${join("\n", formatlist("%s ansible_ssh_host=%s ansible_user=admin ansible_become=true", aws_instance.fusion-solr.*.tags.Name, aws_instance.fusion-solr.*.private_ip))}"
        connection_strings_fusion_zookeeper = "${join("\n",formatlist("%s zk_index=%s ansible_ssh_host=%s ansible_user=admin ansible_become=true", aws_instance.fusion-zookeeper.*.tags.Name, aws_instance.fusion-zookeeper.*.tags.Index, aws_instance.fusion-zookeeper.*.private_ip))}"
        list_bastion = "${join("\n",aws_instance.bastion-server.*.tags.Name)}"
        list_fusion_api = "${join("\n",aws_instance.fusion-api.*.tags.Name)}"
        list_fusion_indexer = "${join("\n",aws_instance.fusion-indexer.*.tags.Name)}"
        list_fusion_solr = "${join("\n",aws_instance.fusion-solr.*.tags.Name)}"
        list_fusion_zookeeper = "${join("\n",aws_instance.fusion-zookeeper.*.tags.Name)}"
        elb_api_fqdn = "apiserver_loadbalancer_domain_name=\"${module.aws-elb.aws_elb_api_fqdn}\""
        elb_api_port = "loadbalancer_apiserver.port=${var.aws_elb_api_port}"
    }
}

resource "null_resource" "inventories" {
  triggers {
    template_rendered = "${data.template_file.inventory.rendered}"
  }

  provisioner "local-exec" {
      command = "echo '${data.template_file.inventory.rendered}' > ../../../inventory/${terraform.env}/hosts"
  }
}