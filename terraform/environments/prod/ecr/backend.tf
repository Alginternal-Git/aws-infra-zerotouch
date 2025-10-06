terraform {
  backend "s3" {
    bucket         = "aws-zero-touch-terraform-states"
    key            = "environments/prod/ecr/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
