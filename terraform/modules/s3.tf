# S3 Bucket
resource "aws_s3_bucket" "site_bucket" {
  bucket = var.domain_name
}

# Disable Block Public Access settings
resource "aws_s3_bucket_public_access_block" "site_bucket_public_access_block" {
  bucket = aws_s3_bucket.site_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


# Bucket policy to allow public read access
resource "aws_s3_bucket_policy" "site_bucket_policy" {
  bucket = aws_s3_bucket.site_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.site_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.site_bucket.bucket
  key          = "index.html"
  etag         = filemd5("../../../static/index.html")
  source       = "../../../static/index.html"
  content_type = "text/html"
  depends_on   = [aws_s3_bucket.site_bucket]
}

resource "aws_s3_object" "favicon" {
  bucket       = aws_s3_bucket.site_bucket.bucket
  key          = "favicon.ico"
  etag         = filemd5("../../../static/favicon.ico")
  source       = "../../../static/favicon.ico"
  content_type = "image/x-icon"
  depends_on   = [aws_s3_bucket.site_bucket]
}

resource "aws_s3_object" "bg" {
  bucket       = aws_s3_bucket.site_bucket.bucket
  key          = "bg.jpg"
  etag         = filemd5("../../../static/bg.jpg")
  source       = "../../../static/bg.jpg"
  content_type = "image/jpeg"
  depends_on   = [aws_s3_bucket.site_bucket]
}

resource "aws_s3_bucket_website_configuration" "web_config" {
  bucket = aws_s3_bucket.site_bucket.id
  index_document {
    suffix = "index.html"
  }
  depends_on = [aws_s3_bucket.site_bucket]
}