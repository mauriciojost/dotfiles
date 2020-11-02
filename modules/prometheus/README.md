# README

## Install

```
# Create user
useradd -m -s /bin/bash prometheus
# Install
mkdir -p /opt/prometheus/data
chown -R prometheus:prometheus /opt/prometheus
su - prometheus
# put on /opt/prometheus/ all prometheus, as user prometheus

# Create daemon via systemd
cd /etc/systemd/system/
ln -s $HOME/.dotfiles/modules/systemd/prometheus.service /etc/systemd/system/prometheus.service

systemctl daemon-reload     # reload config
systemctl start prometheus  # start it
systemctl enable prometheus # launch it on startup

```
