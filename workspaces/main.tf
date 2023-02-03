resource "aws_instance" "example" {
  ami = "ami-0924fa21f01c23f6e"
  instance_type = "t2.micro"
}
