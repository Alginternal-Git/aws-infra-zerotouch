terraform {
  backend "s3" {
    bucket         = "aws-zero-touch-terraform-states"
    key            = "environments/prod/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
