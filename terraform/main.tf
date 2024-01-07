provider "aws" {
    region = "us-east-1"    
  
}
resource "aws_s3_bucket" "exam" {
    bucket = "exam-terraform"
    acl    = "private"
    tags = {
      Name = "exam-terraform"
      Environment = "Dev"
    }

}