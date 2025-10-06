terraform {
  backend "s3" {
    bucket         = "aws-zero-touch-terraform-states"
    key            = "environments/dev/internet-gateway/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
