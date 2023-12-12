resource "aws_api_gateway_rest_api" "my_api" {
  name        = "my_api"
  description = "this is  rest api  for fast api"
}

resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "{proxy+}" #proxy all request to lambdaFunction
}

resource "aws_api_gateway_method" "my_method" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}



resource "aws_api_gateway_integration" "my_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.my_resource.id
  http_method             = "ANY" #aws_api_gateway_method.my_method.http_method
  uri                     = aws_lambda_function.FAST_api.invoke_arn
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
}

resource "aws_api_gateway_deployment" "my-deployment" {
  depends_on  = [aws_api_gateway_integration.my_integration]
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = "stage"
}



output "api_endpoint" {
  value = aws_api_gateway_deployment.my-deployment.invoke_url
}


