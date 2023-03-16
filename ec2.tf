resource "aws_instance" "test_terraform_instance"{
  key_name = "harshalTomcat"
  ami = "ami-0b0ea68c435eb488d"
  instance_type = "t2.micro"

