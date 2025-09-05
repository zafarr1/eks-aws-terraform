terraform {
  backend "s3" {
    bucket         = "aws-eks-terraform-state-1"       # 👈 replace with your bucket
    key            = "eks/terraform.tfstate"  # path inside bucket
    region         = "us-east-1"              # match your region
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
