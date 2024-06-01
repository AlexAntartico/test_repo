resource "aws_iam_instance_profile" "monitoring_metrics_profile" {
  name = "Custom-Monitoring-Metrics-Profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "Minecraft-Custom-Metrics-Role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "Minecraft-Custom-Metric-Policy"
  description = "A test policy for allowing the IAM instance profile to publish to CloudWatch custom monitoring metrics and backup permissions"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:PutMetricData",
        "ec2:DescribeVolumes",
        "ec2:DescribeTags",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams",
        "logs:DescribeLogGroups",
        "logs:CreateLogStream",
        "logs:CreateLogGroup"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameter"
      ],
      "Resource": "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketAcl"
      ],
      "Resource": "${data.terraform_remote_state.s3.outputs.s3_bucket_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:DeleteObject"
      ],
      "Resource": "${data.terraform_remote_state.s3.outputs.s3_bucket_arn}/*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}