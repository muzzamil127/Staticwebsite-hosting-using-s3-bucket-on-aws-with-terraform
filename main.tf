resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
}

variable "bucketname" {
  default = "myterraformbucketmuzzamilwebsiteproject"
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
  resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
  
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
  
}

resource "aws_s3_object" "image1" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "image1.jpg"
  source = "image1.jpg"
  acl = "public-read"
}

resource "aws_s3_object" "image2" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "image2.png"
  source = "image2.png"
  acl = "public-read"
}

resource "aws_s3_object" "image3" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "image3.png"
  source = "image3.png"
  acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "website" {
    bucket = aws_s3_bucket.mybucket.id
     index_document {
     suffix = "index.html"
  }

    error_document {
    key = "error.html"
  } 
  depends_on = [ aws_s3_bucket_acl.example ]
}