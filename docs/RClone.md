# rclone Backup Setup

This guide configures [rclone](https://rclone.org/) for copying server backups to:

- A NAS using SMB/CIFS (`nas`)
- OneDrive (`OneDrive`)

The backup scripts in this repository use these remote names and upload to the
`vaultwarden` directory on each remote.

## 1. Install rclone

```bash
sudo -v
curl https://rclone.org/install.sh | sudo bash
rclone version
```

## 2. Configure the NAS remote

Start the interactive configuration:

```bash
rclone config
```

Create a new remote with these values:

1. Select `n` for **New remote**.
2. Set the name to `nas`.
3. Select **SMB / CIFS** as the storage type.
4. Enter the NAS address, share name, username, and password when prompted.

Check that the remote is reachable:

```bash
rclone lsd nas:
rclone mkdir nas:vaultwarden
rclone lsd nas:vaultwarden
```

## 3. Configure the OneDrive remote

Run the configuration command again:

```bash
rclone config
```

Create a new remote named `OneDrive`, select **Microsoft OneDrive**, and
complete the browser authentication flow. Then verify it:

```bash
rclone lsd OneDrive:
rclone mkdir OneDrive:vaultwarden
rclone lsd OneDrive:vaultwarden
```

If the remote has a different name, update `NAS_DEST` or `OneDrive_DEST` in
`srv/backup_scripts/vaultwarden/Makefile` to match it.

## 4. Test a remote

Create a temporary file and copy it to each remote:

```bash
mkdir -p /tmp/rclone-test
printf '%s\n' 'rclone works' > /tmp/rclone-test/test.txt

rclone copy /tmp/rclone-test nas:rclone-test
rclone copy /tmp/rclone-test OneDrive:rclone-test
```

Confirm the files are present:

```bash
rclone ls nas:rclone-test
rclone ls OneDrive:rclone-test
```

Remove the test files when finished:

```bash
rclone purge nas:rclone-test
rclone purge OneDrive:rclone-test
```

## 5. Run the Vaultwarden backup upload

The backup Makefile finds the newest archive in
`/srv/docker/backups/vaultwarden/` and copies it to both configured remotes:

```bash
make -C ~/projects/home-server/srv/backup_scripts/vaultwarden
```

The default log is written to `/srv/backups/job.log`. To use a different log
file or destination, pass Make variables:

```bash
make -C ~/projects/home-server/srv/backup_scripts/vaultwarden \
	LOG_FILE=/path/to/backup.log \
	NAS_DEST=nas:vaultwarden \
	OneDrive_DEST=OneDrive:vaultwarden
```