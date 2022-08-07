## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ami.ubuntu_20_04](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_region.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_available_aws_availability_zones_names"></a> [available\_aws\_availability\_zones\_names](#output\_available\_aws\_availability\_zones\_names) | A list of the Availability Zone names available to the account |
| <a name="output_available_aws_availability_zones_zone_ids"></a> [available\_aws\_availability\_zones\_zone\_ids](#output\_available\_aws\_availability\_zones\_zone\_ids) | A list of the Availability Zone IDs available to the account |
| <a name="output_aws_region"></a> [aws\_region](#output\_aws\_region) | Details about selected AWS region |
| <a name="output_ubuntu_20_04_aws_ami_id"></a> [ubuntu\_20\_04\_aws\_ami\_id](#output\_ubuntu\_20\_04\_aws\_ami\_id) | AMI ID of Ubuntu 20.04 |
