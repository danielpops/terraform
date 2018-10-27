resource "aws_iam_user" "dpopes" {
  name="dpopes"
}

resource "aws_iam_user" "unprivileged" {
  name="unprivileged"
}

data "aws_iam_policy" "AdministratorAccess" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_policy" "s3-with-mfa" {
  name="s3-with-mfa"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*",
            "Condition": {
                "Bool": {
                    "aws:MultiFactorAuthPresent": "true"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "administrator" {
  name="administrator"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_iam_role" "Admin" {
  name="Admin"
  description = "Administrator"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::066319819083:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "s3-with-mfa" {
  name       = "s3-with-mfa"
  users      = ["${aws_iam_user.unprivileged.name}"]
  policy_arn = "${aws_iam_policy.s3-with-mfa.arn}"
}


resource "aws_iam_role_policy_attachment" "Admin-Administrators" {
    role       = "${aws_iam_role.Admin.name}"
    policy_arn = "${data.aws_iam_policy.AdministratorAccess.arn}"
}

resource "aws_iam_policy_attachment" "administrator" {
  name       = "administrator-access"
  users      = ["${aws_iam_user.dpopes.name}"]
  policy_arn = "${aws_iam_policy.administrator.arn}"
}
