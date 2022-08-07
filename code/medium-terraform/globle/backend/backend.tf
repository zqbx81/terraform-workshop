terraform {
  backend "s3" {
    bucket = "terraform-state-demozeyang"
    key    = "global/backend/terraform-global.tfstate"
    region = "us-east-1"


    dynamodb_table_name = "terraform-locks-160071257600"
    s3_bucket_name      = "160071257600-terraform-states"
    s3_bucket_region    = "ap-southeast-1"
  }
}
