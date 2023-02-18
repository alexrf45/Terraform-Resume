variable "region" {
  description = "AWS REGION"
  type        = string
  default     = "us-east-1"
}

variable "bucket" {
  description = "bucket name"
  type        = string
  default     = ""
}

variable "dynamodb_table_name" {
  description = "Name of the dynamodb table"
  type        = string
  default     = "tf-locks"
}



