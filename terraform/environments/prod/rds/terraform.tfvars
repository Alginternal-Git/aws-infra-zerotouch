aws_region  = "us-west-2"
environment = "prod"

db_name         = "prodapp"
engine          = "mysql"
engine_version  = "8.0"
instance_class  = "db.t3.micro"

allocated_storage     = 100
max_allocated_storage = 1000

username            = "prodadmin"
use_random_password = true

backup_retention_period = 30
backup_window           = "03:00-04:00"
maintenance_window      = "sun:04:00-sun:05:00"

tags = {
  Environment        = "prod"
  Project            = "zero-touch"
  ManagedBy          = "terraform"
  Compliance         = "SOX"
  DataClassification = "Internal"
  SecurityReview     = "Approved"
  CostCenter         = "production"
  Owner              = "production-team"
}
