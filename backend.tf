terraform{
backend "s3" {
    bucket = "harshal-terraform-bucket"
    key    = "terraform/test_backend_terraform"
    region = "us-east-1"
}
}
