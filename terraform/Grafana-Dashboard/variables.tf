variable "grafana_domain" {
  description = "Domain name under which the grafana login is found"
}

variable "grafana_auth" {
  description = "Authentication String used to access Grafana APIs"
  sensitive   = true
}