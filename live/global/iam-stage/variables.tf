variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

variable "give_neo_cloudwatch_full_access" {
  description = "If true, neo gets full access to cloudwatch"
  type        = bool
  default     = "false"
}
