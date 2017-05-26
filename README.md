# Fusion Cluster Setup

## Development environment

Run Terraform to setup the cluster. Run the following steps on your workstation.

```
brew install ansible
brew install terraform

cd fusion/contrib/terraform/aws
export SSH_KEY_FILE="~/.ssh/id_rsa_tf_uchat"
export TF_VAR_AWS_ACCESS_KEY_ID="<AWS Access Key>"
export TF_VAR_AWS_SECRET_ACCESS_KEY="<AWS Secret Key>"
export TF_VAR_AWS_SSH_KEY_NAME="<AWS SSH Key>"
export TF_VAR_AWS_DEFAULT_REGION="us-west-2"
export TF_VAR_AWS_SSH_KEY_FILE="${SSH_KEY_FILE}"
terraform env new devtest
terraform env select devtest
terraform get
terraform plan -var-file="environments/devtest.tfvars" -out devtest.plan
terraform apply devtest.plan
cd ../../../
ansible-playbook -i ./inventory/devtest/hosts hosts.yml -b -v
```

Login to the Bastion host to Run the following Ansible playbooks to setup the cluster.

```
sudo su - root
cd /opt/fusion
ansible-playbook -i ./inventory/devtest/hosts prereqs.yml -b -v
ansible-playbook -i ./inventory/devtest/hosts cluster.yml -b -v
```

### Staging enviroment
```
ansible-playbook -i ./inventory/staging/hosts prereqs.yml -b -v
ansible-playbook -i ./inventory/staging/hosts cluster.yml -b -v
```