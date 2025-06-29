# Pterodactyl-Autobackup

Script otomatis untuk melakukan backup seluruh server di panel Pterodactyl.
Mendukung penyimpanan ke cloud seperti Google Drive (menggunakan rclone) atau server lokal melalui SFTP.


✨ Fitur

  1.Backup otomatis seluruh server berdasarkan UUID
  
  2.Penjadwalan backup (via cron)
  
  3.Kompresi file backup menjadi .tar.gz
  
  4.Upload ke penyimpanan cloud dengan rclone
  
  5.Notifikasi via Discord webhook ketika backup berhasil atau gagal
  
  6.Log detail proses backup


  ⚙️ Teknologi yang digunakan

    Bash: Script utama untuk proses backup dan automasi

    rclone: Untuk sinkronisasi file backup ke cloud

    cron: Menjalankan backup secara berkala

    Discord Webhook: Notifikasi status backup
