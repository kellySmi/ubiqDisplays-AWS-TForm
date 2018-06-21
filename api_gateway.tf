
variable "awsregion" = "us-east-1"
resource "aws_api_gateway_rest_api" "image_gateway" {
  name        = "image_gateway"
  description = "This is the API for images"
}

resource "aws_api_gateway_resource" "imageResource" {
  rest_api_id = "${aws_api_gateway_rest_api.image_gateway.id}"
  parent_id   = "${aws_api_gateway_rest_api.image_gateway.root_resource_id}"
  path_part   = "resource"
}

resource "aws_api_gateway_method" "get_images" {
  rest_api_id   = "${aws_api_gateway_rest_api.image_gateway.id}"
  resource_id   = "${aws_api_gateway_resource.imageResource.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "imageIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.image_gateway.id}"
  resource_id = "${aws_api_gateway_resource.imageResource.id}"
  http_method = "${aws_api_gateway_method.get_images.http_method}"
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.awsregion}:lambda:path/2015-03-31/functions/${aws_lambda_function.image_handler.arn}/invocations"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.arn}"
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.awsregion}:${var.accountId}:${aws_api_gateway_rest_api.image_gateway.id}/*/${aws_api_gateway_method.get_images.http_method}${aws_api_gateway_resource.imageResource.path}"
}
