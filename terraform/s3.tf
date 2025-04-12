# create s3 bucket for ansible script used for umami user_data
resource "aws_s3_bucket" "umami-ansible" {
  bucket = "umami-ansible"
  tags = {
    Name = "umami-ansible"
  }
}

data "archive_file" "umami-ansible" {
  type        = "zip"
  source_dir  = "${path.module}/ansible"
  output_path = "${path.module}/umami-ansible.zip"
}

resource "aws_s3_object" "umami-ansible" {
  bucket = aws_s3_bucket.umami-ansible.bucket
  key    = "umami/umami-ansible.zip"
  source = data.archive_file.umami-ansible.output_path
  etag   = data.archive_file.umami-ansible.output_md5
}