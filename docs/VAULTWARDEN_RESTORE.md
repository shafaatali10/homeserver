# Vaultwarden Restore Procedure

These steps restore a Vaultwarden backup created by `bruceforce/vaultwarden-backup` onto a fresh Vaultwarden instance.

## Assumptions

- Vaultwarden data directory: `/srv/docker/data/vaultwarden`
- Backups directory: `/srv/docker/backups/vaultwarden/`
- Backup format: `.tar.xz`
- Vaultwarden is running with Docker Compose
- Vaultwarden data is owned by `someuser:someuser`

## 1. Stop Vaultwarden

```bash
cd ~/projects/home-server
docker compose stop vaultwarden
```

## 2. Clear the fresh Vaultwarden data directory

>Warning: This deletes the existing Vaultwarden data in this directory. Only do this when restoring onto a 
>fresh instance or when intentionally replacing the existing data.

```bash
sudo rm -rf /srv/docker/data/vaultwarden/*
sudo rm -rf /srv/docker/data/vaultwarden/.[!.]*
```

## 3. Check the backup archive
```
sudo tar -tJf /srv/docker/backups/vaultwarden/<BACKUP_FILE>.tar.xz | head -30
```

## 4. Extract the backup
```
sudo tar -xJf \
  /srv/docker/backups/vaultwarden/<BACKUP_FILE>.tar.xz \
  -C /srv/docker/data/vaultwarden
```

## 5. Restore ownership
```
sudo chown -R 1000:1000 /srv/docker/data/vaultwarden
```

## 6. Start Vaultwarden
```
docker compose up -d vaultwarden
docker logs vaultwarden
```