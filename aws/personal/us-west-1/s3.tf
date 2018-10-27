resource "aws_s3_bucket" "terraform-remote-state" {
    bucket = "terraform-remote-state-us-west-1"
    acl    = "private"
    tags {
        Name        = "terraform-remote-state"
        Description = "This is where the remote state is stored"
    }
}

resource "aws_s3_bucket_policy" "terraform-remote-state" {
  bucket = "${aws_s3_bucket.terraform-remote-state.id}"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DefaultFullAccessWithinAccount",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::066319819083:root"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::terraform-remote-state-us-west-1/*",
                "arn:aws:s3:::terraform-remote-state-us-west-1"
            ]
        }
    ]
}
POLICY
}
