terraform {
    required_version = ">= 0.9.5"
}

/*
* Create Bastion Instances in AWS
*
*/
resource "aws_instance" "bastion-server" {
    ami = "${var.aws_bastion_ami}"
    instance_type = "${var.aws_bastion_size}"
    count = "${length(var.aws_cidr_subnets_public)}"
    associate_public_ip_address = true
    availability_zone  = "${element(var.aws_avail_zones,count.index)}"
    subnet_id = "${element(module.aws-vpc.aws_subnet_ids_public,count.index)}"

    vpc_security_group_ids = [ "${module.aws-vpc.aws_security_group}" ]

    key_name = "${var.AWS_SSH_KEY_NAME}"

    tags {
        Name = "fusion-${var.aws_cluster_name}-bastion-${count.index}"
        Cluster = "${var.aws_cluster_name}"
        Role = "bastion-${var.aws_cluster_name}-${count.index}"
    }

    provisioner "file" {
        source      = "${var.AWS_SSH_KEY_FILE}"
        destination = "/tmp/id_rsa"
        connection {
            type = "ssh"
            user = "${var.ssh_user}"
            private_key = "${file(var.AWS_SSH_KEY_FILE)}"
        }
    }

    provisioner "file" {
        source      = "scripts/bastion.sh"
        destination = "/tmp/script.sh"
        connection {
            type        = "ssh"
            user        = "${var.ssh_user}"
            private_key = "${file(var.AWS_SSH_KEY_FILE)}"
        }
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/script.sh",
            "sudo -H -u root sh -c '/tmp/script.sh'"
        ]
        connection {
            type        = "ssh"
            user        = "${var.ssh_user}"
            private_key = "${file(var.AWS_SSH_KEY_FILE)}"
        }
    }
}
