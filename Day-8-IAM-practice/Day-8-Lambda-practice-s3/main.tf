provider "aws" {
  region = "ap-south-1"
}

#########################################
# UNIQUE BUCKET NAME (IMPORTANT FIX)
#########################################
resource "random_id" "rand" {
  byte_length = 4
}

#########################################
# S3 BUCKET
#########################################
resource "aws_s3_bucket" "bucket" {
  bucket = "ramesh-lambda-bucket-${random_id.rand.hex}"

  tags = {
    Name = "lambda-code-bucket"
  }
}

#########################################
# S3 OBJECT (UPLOAD ZIP)
#########################################
resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.bucket.id
  key    = "lambda/lambda_function.zip"
  source = "lambda_function.zip"

  etag = filemd5("lambda_function.zip")
}

#########################################
# IAM ROLE
#########################################
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

#########################################
# IAM POLICY ATTACHMENTS
#########################################
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_s3_read" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

#########################################
# LAMBDA FUNCTION
#########################################
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"

  role    = aws_iam_role.lambda_role.arn
  handler = "lambda_function.lambda_handler"
  runtime = "python3.12"

  timeout     = 900
  memory_size = 128

  # Pull code from S3
  s3_bucket = aws_s3_bucket.bucket.id
  s3_key    = aws_s3_object.lambda_zip.key

  # IMPORTANT → detects code change
  source_code_hash = filebase64sha256("lambda_function.zip")

  # 🔥 FIX: Ensure S3 upload happens first
  depends_on = [aws_s3_object.lambda_zip]
}