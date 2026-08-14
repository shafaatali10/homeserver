## Steps to setup Homeserver

### Prerequisites
1. Ubuntu 26 Installed
2. Have an access to server (via ssh or direct login) 


### Step 0. Install Ubuntu Updates
```
sudo apt update && sudo apt upgrade -y
```
Optionally remove no-longer-needed packages afterward:
```
sudo apt autoremove -y
```

### Step 1. Install Git
```
sudo apt install -y git
git --version


git config --global user.name "Shafaat Khan"

git config --global user.email "your_email@example.com"

git config --list

```

### Step 2. Install Java

```
sudo apt install -y default-jdk
java --version
javac --version
```

### Step 3. Install Node JS

```
sudo apt install -y nodejs
sudo apt install -y npm
node --version
npm --version
```

### Step 4. Install Python 3
```
sudo apt install -y python3 python3-pip python3-venv
python3 --version
pip3 --version
```

### Step 5. Install Docker
Add new group
```
newgrp docker
```
```
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

```
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
Enable Docker and allow your user to run it without sudo:

```
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
```

Apply the group change by logging out and back in

Verify Docker:

```
docker run hello-world
docker compose version
```


### Folder Structure

```

├── home/
│   └── youruser/
│       ├── Projects/
│       │   ├── app1/
│       │   ├── app2/
│       │   ├── scripts/
│       │   └── ...
│       │
│       ├── Documents/
│       ├── Downloads/
│       ├── Pictures/
│       └── ...
│
├── srv/
│   ├── docker/
│   │   ├── compose/
│   │   │   ├── immich/
│   │   │   ├── jellyfin/
│   │   │   ├── paperless/
│   │   │   ├── homepage/
│   │   │   └── ...
│   │   │
│   │   ├── data/
│   │   │   ├── immich/
│   │   │   ├── postgres/
│   │   │   ├── jellyfin/
│   │   │   └── ...
│   │   │
│   │   ├── backups/
│   │   └── shared/
│   │
│   └── media/
│       ├── movies/
│       ├── tv/
│       ├── music/
│       └── photos/
│
├── opt/
│   └── (optional manually installed software)
│
└── etc/
```