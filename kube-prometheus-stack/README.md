# Installation steps Prometheus, Grafana, Loki, and Promtail

## Install kube prometheus stack
```
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack   --version 60.3.0   --namespace "monitoring"   --set grafana.adminPassword=""   --create-namespace   --dry-run --debug"
```