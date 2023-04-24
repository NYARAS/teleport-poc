resource "aws_iam_role" "cluster" {
  name = "${var.name_prefix}-cluster"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {"Service": "ec2.amazonaws.com"},
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

}

resource "aws_iam_instance_profile" "cluster" {
  name       = "${var.name_prefix}-cluster"
  role       = aws_iam_role.cluster.name
  depends_on = [aws_iam_role_policy.cluster_s3]
}

resource "aws_iam_role_policy" "cluster_s3" {
  name = "${var.name_prefix}-cluster-s3"
  role = aws_iam_role.cluster.id

  policy = jsonencode({
    Version : "2012-10-17"
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "s3:ListBucket",
          "s3:ListBucketVersions",
          "s3:ListBucketMultipartUploads",
          "s3:AbortMultipartUpload"
        ],
        Resource : ["arn:aws:s3:::${aws_s3_bucket.storage.bucket}"]
      },
      {
        Effect : "Allow",
        Action : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion"
        ],
        Resource : ["arn:aws:s3:::${aws_s3_bucket.storage.bucket}/*"]
      }
    ]
  })

}
