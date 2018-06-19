provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "image_handler" {
  function_name = "image_handler"
  s3_bucket = "tform-build"
  s3_key    = "v1.0.0/image_handler.zip"
  handler = "main.handler"
  runtime = "nodejs8.10"
  role = "${aws_iam_role.role_exec.arn}"
}
# resource "aws_lambda_function" "logging_service" {
#   function_name = "logging_service"
#   handler = "main.handler"
#   runtime = "nodejs8.10"
#   s3_bucket = "tform-build"
#   s3_key    = "v1.0.0/logger.zip"
#   role = "${aws_iam_role.role_exec.arn}"
# }

resource "aws_iam_role" "role_exec" {
    name = "role_exec"
    path = "/"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
