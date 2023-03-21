resource "aws_instance" "test_terraform_instance"{
  ami = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  key_name = "harshalTomcat"
  iam_instance_profile = aws_iam_instance_profile.s3_access_ec2_profile.name
  user_data = <<EOF
  #!/bin/bash
  sudo touch /home/ec2-user/ip.txt
  curl http://checkip.amazonaws.com | cat > /home/ec2-user/ip.txt
  aws s3 cp /home/ec2-user/ip.txt s3://harshal-terraform-bucket/ip/ip.txt
  sudo yum install -y mariadb-server
  sudo systemctl start mariadb
  aws s3 cp s3://harshal-terraform-bucket/sql/schema.sql /home/ec2-user/schema.sql
  aws s3 cp s3://harshal-terraform-bucket/sql/mysql_secure_installation /home/ec2-user/mysql_secure_installation 
  aws s3 cp s3://harshal-terraform-bucket/ip/html_script.sh /home/ec2-user/html_script.sh
  sudo chmod 777 /home/ec2-user/html_script.sh
  sudo chmod 700 /home/ec2-user/mysql_secure_installation
  sudo cp /home/ec2-user/mysql_secure_installation /bin/mysql_secure_installation 
  sudo mysql_secure_installation
  sudo pip3 install flask
  sudo pip3 install Flask-Cors
  pip3 install mysql-connector
  touch /home/ec2-user/output.txt
  mysql -t -vv -h localhost -u root -p"root" -A < /home/ec2-user/schema.sql>output.txt
  sudo yum install httpd -y
  sudo service httpd start
  sudo chmod 777 /var/www/html
  sudo touch /var/www/html/ip.js
  sudo chmod 777 /var/www/html/ip.js
  sudo sh /home/ec2-user/html_script.sh
  sudo touch /var/lib/cloud/scripts/per-boot/upload_ip.sh
  sudo chmod 700 upload_ip.sh
  cat <<EOF2> /var/lib/cloud/scripts/per-boot/upload_ip.sh
  export FLASK_APP=/home/ec2-user/app.py
  curl http://checkip.amazonaws.com | cat > /home/ec2-user/ip.txt
  aws s3 cp ip.txt s3://harshal-terraform-bucket/ip/ip.txt
  sudo sh /home/ec2-user/html_script.sh
  sudo service httpd start
  EOF2
  mkdir /home/ec2-user/flask
  sed \'s/DocumentRoot \"\/var\/www\/html\"/DocumentRoot  \"\/home\/ec2-user\/flask\"/g\' httpd.conf > httpd.conf
  EOF
}

resource "aws_iam_instance_profile" "s3_access_ec2_profile" {
  name  = "s3_access_ec2_profile2"
  role = aws_iam_role.role.name
}

