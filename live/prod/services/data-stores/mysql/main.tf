resource "aws_db_instance" "example-prod" {
  identifier_prefix = "terraform-up-and-running-prod"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  skip_final_snapshot = true
  db_name = "example_database_prod"
  username = var.db_username
  password = var.db_password
}
