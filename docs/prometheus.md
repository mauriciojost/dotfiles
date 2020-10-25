# README

These are the basics of Prometheus monitoring system. 

The core exists to collect and expose metrics that are pushed by **exporters**. 
The most common exporter is the **node exporter** which pushes to the core very basic generic metrics.

The configuration is here: 
```
/etc/prometheus/prometheus.yml
```

An exporter I found useful is the process-exporter to have information about processes. It can be found here: 

https://github.com/ncabatoff/process-exporter/releases/tag/v0.7.2

It's installation can be done as a regular .deb.

Via `systemctl` as root you can see them running:

```
...
process-exporter.service                                                                    loaded active running   Process Exporter for Prometheus
prometheus-node-exporter.service                                                            loaded active running   Prometheus exporter for machine metrics
prometheus.service                                                                          loaded active running   Monitoring system and time series database
...
```

To see information about prometheus-node-exporter.service you can do
```
systemctl status  process-exporter.service
```

It's configuration is in (you can see it thanks to the above command): 
```
/etc/process-exporter/all.yaml
```

Prometheus exporters expose a HTTP service. Such service can be regularly scraped to retrieve metric values from there. Once the exporter
is running, you need to configure Prometheus core so that it gets scraped.

For instance, once process-exporter is deployed, you need to add to `/etc/prometheus/prometheus.yml` the following:
```
  - job_name: 'process-exporter'
    static_configs:
      - targets: ['localhost:9256']

```

Then
```
systemctl restart prometheus
```

Systemctl files can be configured via: 

```
sudo vi /usr/lib/systemd/system/process_exporter.service
```
