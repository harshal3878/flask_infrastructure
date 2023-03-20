resource "aws_instance" "test_terraform_instance"{
  ami = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  user_data = <<EOF
  #!/bin/bash
  sudo pip3 install flask
  pip3 install mysql-connector
  sudo yum install mariadb
  sudo yum install httpd
  sudo touch /var/lib/cloud/scripts/per-boot/upload_ip.sh
  sudo chmod 700 upload_ip.sh
  cat <<EOF2> /var/lib/cloud/scripts/per-boot/upload_ip.sh
  curl http://checkip.amazonaws.com | cat > /home/ec2-user/ip.txt
  aws s3 cp ip.txt s3://harshal-terraform-bucket/ip/ip.txt
  EOF2
  mkdir /home/ec2-user/flask
  sed \'s/DocumentRoot \"\/var\/www\/html\"/DocumentRoot  \"\/home\/ec2-user\/flask\"/g\' httpd.conf > httpd.conf
  EOF
}
