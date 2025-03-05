sudo mkdir -p /run/systemd/system/nix-daemon.service.d/
cat << EOF >/run/systemd/system/nix-daemon.service.d/override.conf
[Service]
Environment="https_proxy=socks5h://localhost:7897"
EOF
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon

