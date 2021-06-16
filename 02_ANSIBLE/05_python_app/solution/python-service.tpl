[Unit]
Description=Python API
After=network.target
[Service]
Type=simple
Environment=REDIS_HOST=127.0.0.1
ExecStart=/usr/bin/python3 {{ python_app_dir }}/main.py
StandardInput=tty-force
[Install]
WantedBy=multi-user.target