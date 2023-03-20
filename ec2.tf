resource "aws_instance" "test_terraform_instance"{
  ami = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile. test_project_S3_role.name}"
  user_data = <<EOF
  #!/bin/bash
  sudo pip3 install flask
  pip3 install mysql-connector
  aws s3 cp s3://harshal-terraform-bucket/sql/schema.sql schema.sql
  mysql -t -vv -h localhost -u root -p"root" -A < schema.sql>output.txt
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

resource "aws_iam_instance_profile" "s3_access_ec2_profile" {
  name  = "s3_access_ec2_profile"
  role = "test_project_S3_role"
}

