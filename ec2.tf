resource "aws_instance" "test_terraform_instance"{
  key_name = "harshalTomcat"
  ami = "ami-0b0ea68c435eb488d"
  instance_type = "t2.micro"
  

  provisioner "file"{
    source = var.source_file
    destination = "/home/ubuntu/flask_app.zip" 
    connection {
      host = self.public_ip
      type = "ssh"
      user = "ubuntu"
      private_key = file(var.ssh_key_file)
    }
  }
  provisioner "remote-exec" {
    connection {
      host = self.public_ip
      type = "ssh"
      user = "ubuntu"
      private_key = file(var.ssh_key_file)
    }
    inline = [
      "unzip /home/ubuntu/flask_app.zip",
    ]
  }
}
variable "source_file" {
  type = string
}
variable "ssh_key_file"{
  type = string
}