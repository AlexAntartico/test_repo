terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "2.4.0"
    }
  }
}

provider "grafana" {
  url  = var.grafana_domain
  auth = var.grafana_auth
}
