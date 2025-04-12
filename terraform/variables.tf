variable "umami_pw" {
  description = "Password for the umami admin user"
  type        = string
}

variable "environment" {
  description = "Environment for the umami analytics"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the umami analytics"
  type        = string
}

variable "domain_name" {
  description = "Domain for data lookup in route53"
  type        = string
}

variable "security_group_name" {
  description = "Security group name for the umami analytics"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for the umami analytics"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for the umami analytics"
  type        = string
}

variable "letsencryptemail" {
  description = "Email for letsencrypt"
  type        = string
}