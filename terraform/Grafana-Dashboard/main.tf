resource "grafana_data_source" "prometheus" {
  type = "prometheus"
  name = "TF_PROMETHEUS"
  uid  = "prometheus-tf-test-uid"
  url  = "http://localhost:9090"
}

resource "grafana_dashboard" "linux_default_dashboard" {
  config_json = file("linux-host-dashboard.json")
}