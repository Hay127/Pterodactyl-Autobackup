#!/bin/bash

# Konfigurasi
DATE=$(date +"%Y-%m-%d_%H-%M")
PANEL_DIR="/var/lib/pterodactyl/volumes"
BACKUP_DIR="/tmp/pterodactyl_backup_$DATE"
RCLONE_REMOTE="gdrive:/backup-pterodactyl"  #Sesuaikan dengan konfigurasi rclonemu
NODE_NAME="node1"  # Ganti sesuai nama node
WEBHOOK_URL="https://discord.com/api/webhooks/xxx/yyy"  # Ganti dengan webhook kamu

# Buat folder backup sementara
mkdir -p "$BACKUP_DIR"

# Fungsi kirim report ke Discord
send_discord() {
    STATUS=$1
    MESSAGE=$2
    COLOR=$3
    FILE_COUNT=$4
    TOTAL_SIZE=$5
    curl -H "Content-Type: application/json" -X POST -d "{
        \"embeds\": [{
            \"title\": \"Backup $STATUS - $NODE_NAME\",
            \"fields\": [
                {\"name\": \"Tanggal\", \"value\": \"$DATE\", \"inline\": true},
                {\"name\": \"Jumlah File\", \"value\": \"$FILE_COUNT\", \"inline\": true},
                {\"name\": \"Total Size\", \"value\": \"$TOTAL_SIZE\", \"inline\": true}
            ],
            \"description\": \"$MESSAGE\",
            \"color\": $COLOR,
            \"timestamp\": \"$(date -Iseconds)\"
        }]
    }" "$WEBHOOK_URL"
}

# Mulai backup
{
    echo "Memulai backup Pterodactyl servers..."

    FILE_COUNT=0

    for SERVER_DIR in "$PANEL_DIR"/*; do
        if [ -d "$SERVER_DIR" ]; then
            UUID=$(basename "$SERVER_DIR")
            echo "Backup server: $UUID"
            tar -czf "$BACKUP_DIR/${UUID}.tar.gz" -C "$PANEL_DIR" "$UUID"
            ((FILE_COUNT++))
        fi
    done

    # Hitung total size
    TOTAL_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)

    echo "Upload ke rclone remote..."
    rclone copy "$BACKUP_DIR" "$RCLONE_REMOTE/$DATE/$NODE_NAME" --progress

    echo "Hapus backup lama di remote (>7 hari)..."
    rclone delete --min-age 7d "$RCLONE_REMOTE"

    echo "Bersihkan backup lokal..."
    rm -rf "$BACKUP_DIR"

    echo "Backup selesai!"

    # Kirim notifikasi berhasil (warna hijau: 3066993)
    send_discord "Sukses" "Backup & upload berhasil." 3066993 "$FILE_COUNT" "$TOTAL_SIZE"
} || {
    echo "Backup gagal!"
    # Kirim notifikasi gagal (warna merah: 15158332)
    send_discord "Gagal" "Backup gagal. Cek log!" 15158332 "0" "0"
}
