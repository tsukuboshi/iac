# ====================
#
# Outputs
#
# ====================

output "url_for_enduser" {
  value = "https://${var.sub_domain}.${var.naked_domain}"
}

# output "rds_endpoint" {
#   value = module.rds.rds_endpoint
# }

output "aurora_endpoint" {
  value = module.rdsaurora.aurora_endpoint
}

output "elasticache_endpoint" {
  value = module.elasticache.elasticache_endpoint
}
