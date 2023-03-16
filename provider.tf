variable "access_key" {
  type = string
}
variable "secret_key"{
  type = string
}
variable "region"{
  type = string
  default = "us-east-1"
}
provider "aws"{
  access_key = var.access_key
  secret_key = var.secret_key
  region = "us-east-1"
}
