# Terraform state storage backend
terraform {
  backend "s3" {
    bucket         = "kitchentest-terraform"
    key            = "azure-single/terraform.tfstate"
    dynamodb_table = "kitchen_test"
    region         = "eu-west-3"
  }
}