output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.this.arn
}

output "target_group_arn" {
  description = "The ARN of the ALB target group"
  value       = aws_lb_target_group.this.arn
}

output "alb_zone_id" {
  description = "The hosted zone ID of the ALB (needed for Route53 alias)"
  value       = aws_lb.this.zone_id
}