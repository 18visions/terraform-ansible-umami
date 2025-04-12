# Terraform Ansible Umami

Automated deployment for [Umami Analytics](https://umami.is/) using Terraform and Ansible on AWS.

## Overview

Deploy a self-hosted Umami analytics server on AWS using Terraform for infrastructure provisioning and Ansible for configuration management.

## Prerequisites

- AWS account
- Terraform (v1.0+)
- Existing VPC and security group
- Domain name in Route53
- Email for Let's Encrypt

## Quick Start

1. Clone repository
2. Create `terraform.tfvars` with your values:
   ```hcl
   environment         = "prod"
   vpc_id              = "vpc-xxxxxxxxxxxxxxxxx"
   domain_name         = "yourdomain.com"
   security_group_name = "your-security-group"
   subdomain           = "analytics"
   letsencryptemail    = "your-email@example.com"
   ```
3. Deploy:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```
4. Access Umami at `https://analytics.yourdomain.com`

## Components

- EC2 instance with Docker and Docker Compose
- PostgreSQL database for data storage
- Nginx reverse proxy with Let's Encrypt SSL
- S3 bucket for Ansible scripts
- Route53 DNS configuration

## Security

- IMDSv2 enforcement
- SSL/TLS encryption
- Default credentials in docker-compose.yaml (change for production)
