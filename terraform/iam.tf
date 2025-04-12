# iam instance role
resource "aws_iam_instance_profile" "umami-web-prod" {
  name = "umami-web-${var.environment}"
  role = aws_iam_role.umami-role.name
}

# iam role that allows full ec2 access to the instance with ssm managed core policy
resource "aws_iam_role" "umami-role" {
  name               = "umami-web-${var.environment}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonEC2RoleforSSM" {
  role       = aws_iam_role.umami-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  role       = aws_iam_role.umami-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2FullAccess" {
  role       = aws_iam_role.umami-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
