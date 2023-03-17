resource "aws_instance" "test_terraform_instance"{
  key_name = "harshalTomcat"
  ami = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
}
