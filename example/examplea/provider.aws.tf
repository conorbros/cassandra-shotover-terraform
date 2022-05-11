provider "aws" {
  region = "us-west-1"
  default_tags {
    tags = {
      createdby = "terraform"
      module    = "terraform-aws-vpc"
      owner     = "Conor Brosnan"
    }
  }
}

provider "tls" {
}

provider "http" {
}
