terraform {
  backend "s3" {
    bucket = "aws-zero-touch-terraform-states"   # Correct bucket name
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "terraform-locks"  # optional, deprecated warning
    # use_lockfile = true                 # recommended for newer Terraform
  }
}
