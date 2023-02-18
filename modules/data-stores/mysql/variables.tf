variable "db_name" {
  description = "Name for the db"
  type        = string
  default     = null
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  default     = null
}

variable "db_password" {
  description = "The passsoword for the database"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "Days to retain backups. Must be > 0 to enable replication"
  type        = number
  default     = null
}

variable "replicate_source_db" {
  description = "If specified, replicate the RDS database at the given ARN"
  type        = string
  default     = null
}