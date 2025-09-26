sudo mkdir -p /run/systemd/system/nix-daemon.service.d/
cat << EOF >/run/systemd/system/nix-daemon.service.d/override.conf
[Service]
Environment="https_proxy=http://localhost:7897"
Environment="http_proxy=http://localhost:7897"
Environment="all_proxy=http://localhost:7897"
EOF
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon

