.DEFAULT_GOAL := backup

SHELL := /bin/bash

BACKUP_DIR ?= /srv/docker/backups/vaultwarden
LOG_FILE ?= /srv/backups/job.log
NAS_DEST ?= nas:vaultwarden
ONEDRIVE_DEST ?= onedrive:vaultwarden
NTFY_URL ?=
NTFY_PRIORITY ?= default

.PHONY: backup

backup:
	@mkdir -p "$(dir $(LOG_FILE))"
	@exec > >(tee -a "$(LOG_FILE)") 2>&1; \
	set -Eeuo pipefail; \
	started_at=$$(date --iso-8601=seconds); \
	notify() { \
		local message="$$1"; \
		[[ -n "$(NTFY_URL)" ]] || return 0; \
		curl --fail --silent --show-error \
			-H 'Title: Vaultwarden backup' \
			-H 'Priority: $(NTFY_PRIORITY)' \
			-d "$$message" "$(NTFY_URL)" || \
			printf '%s\n' 'WARNING: ntfy notification failed'; \
	}; \
	on_exit() { \
		status=$$?; \
		if [[ $$status -ne 0 ]]; then \
			notify "Vaultwarden backup failed (exit $$status)"; \
		fi; \
		exit "$$status"; \
	}; \
	trap on_exit EXIT; \
	cd "$(BACKUP_DIR)"; \
	latest_file=$$(find . -maxdepth 1 -type f -printf '%T@ %p\n' | sort -nr | cut -d' ' -f2- | head -n 1); \
	[[ -n "$$latest_file" ]] || { printf '%s\n' 'ERROR: no backup file found'; exit 1; }; \
	printf '[%s] Copying %s to %s\n' "$$started_at" "$$latest_file" "$(NAS_DEST)"; \
	rclone copy "$$latest_file" "$(NAS_DEST)"; \
	printf '[%s] Copying %s to %s\n' "$$(date --iso-8601=seconds)" "$$latest_file" "$(ONEDRIVE_DEST)"; \
	rclone copy "$$latest_file" "$(ONEDRIVE_DEST)"; \
	notify "Vaultwarden backup succeeded: $$latest_file"; \
	printf '[%s] Backup completed successfully\n' "$$(date --iso-8601=seconds)"
