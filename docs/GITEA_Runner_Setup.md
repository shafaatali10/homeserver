Install the runner binary on the host:

```
sudo useradd --system --create-home \
  --home-dir /home/gitea-runner \
  --shell /usr/sbin/nologin \
  gitea-runner
```  

```
cd /home/gitea-runner

# Download the appropriate act_runner binary from:
# https://dl.gitea.com/act_runner/


wget https://dl.gitea.com/gitea-runner/3.4.2/gitea-runner-3.4.2-linux-amd64 \
  -O act_runner

chmod +x act_runner
./act_runner generate-config > config.yaml
```

Register it against your Dockerized Gitea:

```
./act_runner register \
  --instance http://127.0.0.1:3000 \
  --token YOUR_RUNNER_TOKEN \ # Gitea → Site Administration → Actions → Runners
  --name home-server \
  --labels linux-host:host
```  

Get the runner token from:

```
Gitea → Site Administration → Actions → Runners
```




Then run it as a systemd service using a dedicated non-root user:


```
sudo chown -R gitea-runner:gitea-runner /home/gitea-runner
sudo nano /etc/systemd/system/gitea-runner.service
```

Paste:

```
[Unit]
Description=Gitea Actions Runner
Wants=network-online.target
After=network-online.target

[Service]
User=gitea-runner
Group=gitea-runner
WorkingDirectory=/home/gitea-runner
ExecStart=/home/gitea-runner/act_runner daemon --config /home/gitea-runner/config.yaml
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

4. Enable and start it

```
sudo systemctl daemon-reload
sudo systemctl enable --now gitea-runner
```

```
sudo systemctl status gitea-runner
```



Your workflow can target the host runner:

```
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: linux-host
    steps:
      - uses: actions/checkout@v4

      - name: Run deployment
        run: ./scripts/deploy.sh
```        


#### Admin Page should see idle