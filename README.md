# cassandra-shotover-terraform

## Setup Key

Create an ssh key and store it in `~/.ssh/keys/aws`.

Change the `public_key` variable in `aws_instance.cassandra.tf` to your public key.

## Build AMI

In `packer/apache-cassandra/values.auto.pkrvar.hcl` set your desired `vpc_id`, `region`, `subnet_id` and `instance_type`.

In `packer` run:

- `packer build apache-cassandra`

## Deploy infrastructure

In `example/examplea` run:

- `terraform init`
- `terraform apply`
