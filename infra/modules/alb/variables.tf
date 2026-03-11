variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the load balancer"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets for the ALB"
  type        = list(string)
}

variable "security_group" {
  description = "Security group for ALB"
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN"
  type        = string
}