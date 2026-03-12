resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  subject_alternative_names = ["tm.${var.domain_name}"]
  validation_method         = "DNS"

  tags = {
    Name = "${var.project_name}-certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}
