TF_VAR_region ?=eu-west-1

TF_VAR_cluster_name ?=teleport-poc

TF_VAR_key_name ?=terraform-key

TF_VAR_license_path ?=

TF_VAR_ami_name ?= gravitational-teleport-ami-oss-12.2.4

TF_VAR_route53_zone ?=calvineotieno.com

TF_VAR_route53_domain ?=cluster.calvineotieno.com

TF_VAR_add_wildcard_route53_record ?= true

TF_VAR_enable_mongodb_listener ?= true

TF_VAR_enable_mysql_listener ?= true

TF_VAR_enable_postgres_listener ?= true

TF_VAR_s3_bucket_name ?=teleport.example.com

export

# Plan launches terraform plan
.PHONY: plan
plan:
	terraform init
	terraform plan

# Apply launches terraform apply
.PHONY: apply
apply:
	terraform init
	terraform apply

# Destroy deletes the provisioned resources
.PHONY: destroy
destroy:
	terraform init
	terraform destroy
