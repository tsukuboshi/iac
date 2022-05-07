# ====================
#
# Cache Distribution
#
# ====================
resource "aws_cloudfront_distribution" "tf_cloudfront_distribution" {

  origin {
    domain_name = aws_route53_record.tf_route53_record_cf_alb_access.fqdn
    origin_id   = aws_lb.tf_alb.name

    custom_origin_config {
      origin_protocol_policy = var.default_origin_protocol_policy
      origin_ssl_protocols   = var.default_origin_ssl_protocols
      http_port              = 80
      https_port             = 443
    }

    custom_header {
      name  = var.custom_header_name
      value = var.custom_header_value
    }
  }

  default_cache_behavior {
    allowed_methods = var.default_cb_allowed_methods
    cached_methods  = var.default_cb_cached_methods

    target_origin_id = aws_lb.tf_alb.name

    forwarded_values {
      query_string = var.default_cb_query_string
      cookies {
        forward = var.default_cb_cookies_forward
      }
    }

    viewer_protocol_policy = var.default_cb_viewer_protocol_policy
    min_ttl                = var.default_cb_min_ttl
    default_ttl            = var.default_cb_default_ttl
    max_ttl                = var.default_cb_max_ttl
    compress               = var.default_cb_compress
  }

  origin {
    domain_name = aws_s3_bucket.tf_bucket_cf_static.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.tf_bucket_cf_static.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.tf_cf_s3_origin_access_identity.cloudfront_access_identity_path
    }
  }


  ordered_cache_behavior {
    path_pattern    = var.ordered_cb_path_pattern
    allowed_methods = var.ordered_cb_allowed_methods
    cached_methods  = var.ordered_cb_cached_methods

    target_origin_id = aws_s3_bucket.tf_bucket_cf_static.id

    forwarded_values {
      query_string = var.ordered_cb_query_string
      cookies {
        forward = var.ordered_cb_cookies_forward
      }
    }

    viewer_protocol_policy = var.ordered_cb_viewer_protocol_policy
    min_ttl                = var.ordered_cb_min_ttl
    default_ttl            = var.ordered_cb_default_ttl
    max_ttl                = var.ordered_cb_max_ttl
    compress               = var.ordered_cb_compress
  }

  restrictions {
    geo_restriction {
      restriction_type = var.cf_geo_restriction_type
    }
  }

  aliases = ["${var.naked_domain}"]

  enabled         = var.cf_enabled
  is_ipv6_enabled = var.cf_is_ipv6_enabled
  price_class     = var.cf_price_class

  logging_config {
    include_cookies = var.cf_log_include_cookies
    bucket          = "${aws_s3_bucket.tf_bucket_cf_log.bucket}.s3.amazonaws.com"
    prefix          = var.cf_log_prefix
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.tf_acm_cf_cert.arn
    minimum_protocol_version = var.cf_minimum_protocol_version
    ssl_support_method       = var.cf_ssl_support_method
  }

  depends_on = [
    aws_acm_certificate_validation.tf_acm_cf_cert_valid
  ]
}

resource "aws_cloudfront_origin_access_identity" "tf_cf_s3_origin_access_identity" {}
