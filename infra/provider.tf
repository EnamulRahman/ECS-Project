# tells terraform to use AWSA

terraform {
    required version = ">= 1.6.0"

    required providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0" 
        }
    }
}

# sets default region 

provider "aws" {
  region = var.aws_region

# auto tags all resources

  default_tags {
    tags = { 
        Project = "Memos" 
        ManagedBy = "terraform"
    }
  }
}
