#S3 Bucket
resource "aws_s3_bucket" "project5-s3bucket" {
  bucket = "project5-bucket"
  acl    = "public-read"

  tags = {
    Name        = "project5-bucket"
  }
}