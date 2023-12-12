

data "external" "env_vars" {
 program = ["sh","${path.module}/env.sh","${path.module}/.env.stage"]                       # program = ["bash", "-c", "cat .env.stage"]
}
  
resource "aws_lambda_function" "FAST_api" {
  function_name = "FAST_api"
  role          = aws_iam_role.lambda_role.arn
  package_type  = "Image"
  image_uri     =  "454143665149.dkr.ecr.ap-south-1.amazonaws.com/fastapi-image:latest"
  timeout       = 60
  source_code_hash = ("main.py")
  handler =  "main.handler"
  runtime = "python3.8"
  
 
  environment  {
    variables = {
        STAGE = file("${path.module}/.env.stage")                             # stage = data.external.env_vars.result 
        
          
        }
    
    }
  }


# file function is used here for reads context of .env and 
#path module is special variable in terraform which represent the path of terraform configration




#data "external" "env_vars" {
#  program = [ "bash" "-c" , "cat anv.vars"] 

 # variable = {
    # stage= data.external.env_vars.result["stage"] #
 
 # merge(file("${path.module}./env.stage"), 

#"ADDITIONAL_VARIABLE" = "additional value",


