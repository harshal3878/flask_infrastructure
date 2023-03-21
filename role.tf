data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_policy_attachment" "demo-attach" {
  name       = "flask_role_attachment"
  roles      = [aws_iam_role.role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role" "role" {
  name               = "ec2_s3_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}