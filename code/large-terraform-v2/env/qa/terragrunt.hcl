terraform {
  extra_arguments "disable_input" {
    commands  = get_terraform_commands_that_need_input()
    arguments = ["-input=false"]
  }
  extra_arguments "retry_lock" {
    commands = [
      "init",
      "apply",
      "refresh",
      "import",
      "plan",
      "taint",
      "untaint"
    ]
    arguments = [
      "-lock-timeout=20m"
    ]
  }
}

remote_state {
  backend      = "s3"
  disable_init = tobool(get_env("TERRAGRUNT_DISABLE_INIT", "false"))

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    encrypt        = true
    region         = "ap-southeast-1"
    key            = format("%s/terraform.tfstate", path_relative_to_include())
    bucket         = format("terraform-states-%s", get_aws_account_id())
    dynamodb_table = format("terraform-locks-%s", get_aws_account_id())

    skip_metadata_api_check     = true
    skip_credentials_validation = true
  }
}

generate "main_providers" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "ap-southeast-1"
  profile = "saml"

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
}
EOF
}
