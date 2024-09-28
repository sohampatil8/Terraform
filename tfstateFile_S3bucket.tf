# main.tf
provider "aws" {
  region = "us-east-1"  # Change region accordingly
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket"
  acl    = "private"
  
  versioning {
    enabled = true
  }

  tags = {
    Name = "Terraform state bucket"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform locks table"
  }
}

# Backend configuration for storing Terraform state in S3
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"   # S3 bucket for state storage
    key            = "path/to/my/terraform.tfstate" # The path within the bucket
    region         = "us-east-1"                   # Bucket region
    dynamodb_table = "terraform-state-locks"       # DynamoDB table for state locking
    encrypt        = true                          # Encrypt the state file
  }
}
