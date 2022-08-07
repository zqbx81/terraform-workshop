terraform {
  backend "s3" {
    bucket                      = "terraform-states-160071257600"
    dynamodb_table              = "terraform-locks-160071257600"
    encrypt                     = true
    key                         = "./terraform.tfstate"
    region                      = "ap-southeast-1"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}
