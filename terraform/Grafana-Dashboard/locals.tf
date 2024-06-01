data "grafana_data_source" "from_name" {
  name = grafana_data_source.prometheus.name
}

data "grafana_data_source" "from_id" {
  id = grafana_data_source.prometheus.id
}

data "grafana_data_source" "from_uid" {
  uid = grafana_data_source.prometheus.uid
}