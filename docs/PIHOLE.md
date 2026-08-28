# Pi-hole Docker Setup

## Step 1 — Create a Permanent Folder

This keeps your Pi-hole configuration safe even if containers are recreated.

I recommend:

```bash
mkdir -p ~/pihole
cd ~/pihole
```

## Step 2 — Create Docker Compose File

Create:

```bash
nano compose.yml
```

Paste this:

```yaml
services:
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    restart: unless-stopped

    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "8080:80/tcp"

    environment:
      TZ: "Asia/Qatar"
      WEBPASSWORD: "$PIHOLE_PWD"

    volumes:
      - ./etc-pihole:/etc/pihole
      - ./etc-dnsmasq.d:/etc/dnsmasq.d

    cap_add:
      - NET_ADMIN
```

<code>Check the password in variables $PIHOLE_PWD</code>

Save:

```
CTRL+O  
ENTER  
CTRL+X  
```

### Why Port 8080?

Normally Pi-hole uses port 80.

But Ubuntu servers sometimes already use port 80 for something else later.

Using:

```
8080:80
```

means:

- Pi-hole internal port = 80
- Server access port = 8080

So web interface becomes:

http://SERVER-IP:8080/admin

Example:

http://192.168.x.x:8080/admin/login

## Step 3 — Start Pi-hole

Run:

```bash
docker compose up -d
```

Check status:

```bash
docker ps
```

You should see:

```
pihole
```

running.

## Step 4 — Find Server IP

Run:

```bash
ip a
```

Look for something like:

```
192.168.x.x
```

That is your Ubuntu server IP.

## Step 5 — Open Pi-hole Web UI

From your browser:

http://SERVER-IP:8080/admin

Example:

http://192.168.x.x:8080/admin

Login using the password from:

WEBPASSWORD
## STEP 6 — Configure Router DNS

This is the important part.

Go to your router settings.

Find:

LAN
DHCP
DNS Server

Set Primary DNS to:

YOUR-UBUNTU-IP

Example:

192.168.x.x

Save and reboot router if needed.

## STEP 7 — Reconnect Devices

Devices may cache old DNS.

Simplest method:

Turn Wi-Fi off/on
Reconnect devices
Or reboot devices
## STEP 8 — Test Pi-hole

Visit:

http://pi.hole/admin

or:

http://SERVER-IP:8080/admin

You should see DNS queries appearing live.

Try visiting ad-heavy websites.

You should notice:

fewer ads
blocked domains count increasing
Important: Static IP

Your Ubuntu server should NOT change IP.

### Best approach:

Reserve the IP in your router DHCP settings.

### Example:

192.168.x.x always assigned to Ubuntu server

This is better than manually configuring Ubuntu networking initially.

Useful Docker Commands
View logs
docker logs -f pihole
Restart
docker restart pihole
Stop
docker stop pihole
Update Pi-hole

Go into folder:

```
cd ~/docker/pihole
```

Then:

```
docker compose pull
docker compose up -d
```

## Backup Strategy

The important data is already stored here:

```
~/docker/pihole
```

Back up this folder only.

Example:

```
tar -czf pihole-backup.tar.gz ~/docker/pihole
```

After Ubuntu reinstall:

Install Docker
Restore folder
Run:
docker compose up -d

Done.


Open Pi-hole admin page:

http://SERVER-IP:8080/admin

Go to:

Settings → DNS

Find:

Interface listening behavior

Select:

Permit all origins



---

## Issues Faced

## Issue #1 - Error

```
Error response from daemon: failed to set up container networking: driver failed programming external connectivity on endpoint pihole (6da33bbdf6f4a02ee051673ba500b320f94a1612402a4c3b39b029943bf1d7d5): failed to bind host port 0.0.0.0:53/tcp: address already in use
```

You can confirm with:

```
sudo lsof -i :53
```

You’ll probably see something like:

<code>systemd-resolved</code>

Fix (Recommended for Home Servers)
### STEP 1 — Disable systemd-resolved

Run:

```
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
```
### STEP 2 — Replace resolv.conf

Ubuntu normally creates this automatically.

Remove it:

```
sudo rm /etc/resolv.conf
```

Create a new one:

```
echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf
```
You can also use:

8.8.8.8

instead of Cloudflare.

### STEP 3 — Restart Docker
```
sudo systemctl restart docker
```

---
## Issue #2 - Password not working

Set the new password with the below command

```
docker exec -it pihole pihole setpassword
```


---
## Issue #3 - Warning
### Pihole logs - WARNING dnsmasq: ignoring query from non-local network 192.168.x.x What does it mean?

Open Pi-hole admin page:

http://SERVER-IP:8080/admin

Go to:

Settings → DNS

Find:

Interface listening behavior

Select:
Permit all origins

```
docker restart pihole
```

---