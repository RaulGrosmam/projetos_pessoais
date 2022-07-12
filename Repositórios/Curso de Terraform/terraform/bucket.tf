resource "aws_s3_bucket" "testezaobonitobucketv2" {
  bucket = "balde-testev2"
  acl    = "private"

  tags = {
    Name        = "Baldão testão"
  }
}