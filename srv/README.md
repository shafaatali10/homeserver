### Setup `/srv ` directory

1. Run `setup-srv.sh`

```
sudo ./setup-srv.sh
```


2. Run `setup-apps.sh`

```
./setup-apps.sh
```

To set up only one app, pass its name:

```sh
./setup-apps.sh gitea
./setup-apps.sh vaultwarden
./setup-apps.sh pihole
./setup-apps.sh nextcloud
```

Running without an argument is equivalent to `./setup-apps.sh all`.


#### Vaultwarden Admin Setup
Generate an Argon2 hash:

```sh
docker run --rm -it vaultwarden/server:latest /vaultwarden hash
```
Then add it to your `docker-compose.yml`:

```yaml
services:
  vaultwarden:
    image: vaultwarden/server:latest
    environment:
      ADMIN_TOKEN: "$argon2id$v=19$m=19456,t=2,p=1$..."
```

> If vaultwarden admin password doesn't work, use readable password in ADMIN_TOKEN,
> and then execute `docker run --rm -it vaultwarden/server:latest /vaultwarden hash` 
> and replace that token in ADMIN_TOKEN from `/admin` page
