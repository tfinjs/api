provider "aws" {
  assume_role = {
    role_arn = "arn:aws:iam::133713371337:role/DeploymentRole"
  }

  region = "eu-north-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-prod"
    key    = "tijpetshopf24hqc.terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_iam_policy" "cloudwatch_attachable_policy" {
  policy = <<EOF
{"Version":"2012-10-17","Statement":[{"Action":["logs:CreateLogStream"],"Effect":"Allow","Resource":"arn:aws:logs:eu-north-1:133713371337:log-group:/aws/lambda/tijpetshop1r2h0yy:*"},{"Action":["logs:PutLogEvents"],"Effect":"Allow","Resource":"arn:aws:logs:eu-north-1:133713371337:log-group:/aws/lambda/tijpetshop1r2h0yy:*:*"}]}
EOF
}

output "tfinjs_arn" {
  value = "${aws_iam_policy.cloudwatch_attachable_policy.arn}"
}
