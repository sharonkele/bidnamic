resource "aws_s3_bucket" "b" {
  bucket                      = "flaskapp"
  region                      = var.region
  tags                        = local.tags
  versioning {
    enabled    = false
    mfa_delete = false
  }

  website {
    index_document = "home.html"
  }
}
resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.id
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "s3:GetObject"
          Effect    = "Allow"
          Principal = "*"
          Resource  = aws_s3_bucket.b.arn
          Sid       = "PublicReadGetObject"
        },
      ]
      Version = "2012-10-17"
    }
  )
}