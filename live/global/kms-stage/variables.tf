variable "region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}

variable "cmk_alias" {
  description = "Alias of KMS key"
  type = string
  default = "alias/kms-cmk-admin"
}
