resource "aws_instance" "test_terraform_instance"{
  ami = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  user_data = <<EOF
  #!/bin/bash
  sudo pip3 install flask
  pip3 install mysql-connector
  sudo yum install mariadb
  sudo yum install httpd
  mkdir /home/ec2-user/flask
  EOF
}
