/*
 * # module: lambda-folder-index
 *
 * This module deploys a lambda@edge that rewrites requests to uris ending in / to /index.html
 *
 * For example: a request to /foo/bar/ would be rewritten to /foo/bar/index.html
 *
 */
module "label" {
  source     = "cloudposse/label/null"
  version    = "0.24.1"
  context    = module.this.context
  attributes = ["lambda", "folder-index"]
}

module "lambda_folder_index" {
  source                            = "terraform-aws-modules/lambda/aws"
  function_name                     = module.label.id
  description                       = "Redirects requests for /  to /index.html"
  handler                           = "index.handler"
  runtime                           = "nodejs12.x"
  source_path                       = "${path.module}/lambda/"
  lambda_at_edge                    = true
  cloudwatch_logs_retention_in_days = 14
  cloudwatch_logs_tags              = module.label.tags
  tags                              = module.label.tags
}

