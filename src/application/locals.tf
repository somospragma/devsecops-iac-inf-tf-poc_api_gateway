locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}


locals {
  swagger_api_public = data.template_file.template_file_api_swagger_public.rendered
}


