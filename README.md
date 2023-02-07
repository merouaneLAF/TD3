# TD3
Déployer un cluster de web servers


merouane@merouane-VirtualBox:~/terraform/TD3$ terraform graph
digraph {
        compound = "true"
        newrank = "true"
        subgraph "root" {
                "[root] aws_autoscaling_group.exemple (expand)" [label = "aws_autoscaling_group.exemple", shape = "box"]
                "[root] aws_launch_configuration.exemple (expand)" [label = "aws_launch_configuration.exemple", shape = "box"]
                "[root] aws_security_group.instance (expand)" [label = "aws_security_group.instance", shape = "box"]
                "[root] data.aws_subnet_ids.default (expand)" [label = "data.aws_subnet_ids.default", shape = "box"]
                "[root] data.aws_vpc.default (expand)" [label = "data.aws_vpc.default", shape = "box"]
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" [label = "provider[\"registry.terraform.io/hashicorp/aws\"]", shape = "diamond"]
                "[root] var.security_group_name" [label = "var.security_group_name", shape = "note"]
                "[root] aws_autoscaling_group.exemple (expand)" -> "[root] aws_launch_configuration.exemple (expand)"
                "[root] aws_autoscaling_group.exemple (expand)" -> "[root] data.aws_subnet_ids.default (expand)"
                "[root] aws_launch_configuration.exemple (expand)" -> "[root] aws_security_group.instance (expand)"
                "[root] aws_security_group.instance (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
                "[root] aws_security_group.instance (expand)" -> "[root] var.security_group_name"
                "[root] data.aws_subnet_ids.default (expand)" -> "[root] data.aws_vpc.default (expand)"
                "[root] data.aws_vpc.default (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_autoscaling_group.exemple (expand)"
                "[root] root" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)"
        }
}





merouane@merouane-VirtualBox:~/terraform/TD3$ terraform plan
data.aws_vpc.default: Reading...
data.aws_vpc.default: Read complete after 1s [id=vpc-0acc0eb8c3479f699]
data.aws_subnet_ids.default: Reading...
data.aws_subnet_ids.default: Read complete after 0s [id=vpc-0acc0eb8c3479f699]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # aws_autoscaling_group.exemple will be created
  + resource "aws_autoscaling_group" "exemple" {
      + arn                       = (known after apply)
      + availability_zones        = (known after apply)
      + default_cooldown          = (known after apply)
      + desired_capacity          = (known after apply)
      + force_delete              = false
      + force_delete_warm_pool    = false
      + health_check_grace_period = 300
      + health_check_type         = (known after apply)
      + id                        = (known after apply)
      + launch_configuration      = (known after apply)
      + max_size                  = 10
      + metrics_granularity       = "1Minute"
      + min_size                  = 2
      + name                      = (known after apply)
      + name_prefix               = (known after apply)
      + protect_from_scale_in     = false
      + service_linked_role_arn   = (known after apply)
      + vpc_zone_identifier       = [
          + "subnet-01f93cb7cc5058d02",
          + "subnet-0af994196a95a94e0",
          + "subnet-0ecb6d192f6cfad86",
        ]
      + wait_for_capacity_timeout = "10m"

      + tag {
          + key                 = "Name"
          + propagate_at_launch = true
          + value               = "terraform-asg-example"
        }
    }

  # aws_launch_configuration.exemple will be created
  + resource "aws_launch_configuration" "exemple" {
      + arn                         = (known after apply)
      + associate_public_ip_address = (known after apply)
      + ebs_optimized               = (known after apply)
      + enable_monitoring           = true
      + id                          = (known after apply)
      + image_id                    = "ami-0c55b159cbfafe1f0"
      + instance_type               = "t2.micro"
      + key_name                    = (known after apply)
      + name                        = (known after apply)
      + name_prefix                 = (known after apply)
      + security_groups             = (known after apply)
      + user_data                   = "0fec79290398db0299499a90f9e30c12a105dc3f"

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + no_device             = (known after apply)
          + snapshot_id           = (known after apply)
          + throughput            = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + throughput            = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_security_group.instance will be created
  + resource "aws_security_group" "instance" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 8080
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 8080
            },
        ]
      + name                   = "terraform-exemple-instance"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.
╷
│ Warning: Deprecated Resource
│ 
│   with data.aws_subnet_ids.default,
│   on main.tf line 50, in data "aws_subnet_ids" "default":
│   50: data "aws_subnet_ids" "default" {
│ 
│ The aws_subnet_ids data source has been deprecated and will be removed in a future version. Use the aws_subnets data source
│ instead.
│ 
│ (and one more similar warning elsewhere)
╵

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run
"terraform apply" now.