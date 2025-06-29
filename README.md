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

  1.Bash: Script utama untuk proses backup dan automation

  2.rclone: Untuk sinkronisasi file backup ke cloud

  3.cron: Menjalankan backup secara berkala

  4.Discord Webhook: Notifikasi status backup

  
  Langkah Instalasi:

  curl https://rclone.org/install.sh | sudo bash => untuk menginstall rclone 

  rclone config => Isi semua konfigurasi yang diperlukan

  rclone lsd [Nama]: => Fungsinya adalah untuk mengecek apakah rclone berhasil terhubung ke cloud drive kalian


  

