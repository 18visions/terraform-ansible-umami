resource "aws_instance" "umami-web-prod" {
  # base ubuntu image in aws
  ami                    = "ami-0606dd43116f5ed57"
  instance_type          = "t2.micro" # t2.micro is free tier eligible
  iam_instance_profile   = aws_iam_instance_profile.umami-web-prod.name
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  user_data = base64encode(templatefile("templates/user_data.sh", {
    zip       = "umami-${data.archive_file.umami-ansible.output_md5}.zip"
    s3_bucket = aws_s3_bucket.umami-ansible.bucket
    hostname  = "${var.environment}-umami-web-prod"
    domain    = "${var.subdomain}.${var.domain_name}"
    letsencryptemail = var.letsencryptemail
    umami_compose_dir = "/opt/umami"
  }))

  root_block_device {
    volume_type = "gp3"
    throughput  = 125
    iops        = 3000
    volume_size = 30
    tags = {
      Name   = "${var.environment}-umami-prod-rootvol"
      Backup = "False"
    }
  }

  metadata_options {
    http_tokens               = "required"  # Enforces the use of IMDSv2
    http_endpoint             = "enabled"   # Enables the metadata service
    http_put_response_hop_limit = 2         # (Optional) Controls the allowed network hops for metadata requests
    http_protocol_ipv6        = "disabled"  # (Optional) Disable IPv6 if not needed
  }

  tags = {
    Name        = "${var.environment}-umami-web-prod"
    OS          = "Ubuntu"
    Platform    = "Linux"
    Environment = var.environment
  }
}