PRD: Sistem Manajemen Ruang Perkuliahan (Mobile App)

1. Ringkasan Proyek

Membangun platform manajemen ruang perkuliahan yang memungkinkan pengguna memantau ketersediaan ruangan secara real-time dan melakukan pemesanan tanpa terjadi bentrok jadwal.

2. Tujuan Utama
	•	Memberikan visibilitas status ruangan (terisi/kosong) secara instan kepada mahasiswa dan dosen.
	•	Mencegah terjadinya jadwal perkuliahan atau pemesanan yang bertabrakan (conflict validation).
	•	Mempermudah proses pembatalan kelas dan pengosongan ruangan secara digital.

3. Persona Pengguna
	•	Admin: Mengelola data gedung, ruangan, dan akun pengguna.
	•	Dosen: Melihat jadwal, memesan ruang untuk kelas tambahan, dan membatalkan jadwal yang sedang berlangsung.
	•	Mahasiswa: Melihat ketersediaan ruangan dan melakukan booking untuk kegiatan belajar mandiri atau diskusi.

4. Fitur Utama (Functional Requirements)

A. Autentikasi & Keamanan
	•	Sistem login dan register menggunakan JWT (JSON Web Token).
	•	Role-Based Access Control (RBAC) untuk membatasi fitur berdasarkan jenis pengguna (Admin/Dosen/Mahasiswa).

B. Manajemen Ruangan
	•	Menampilkan daftar gedung dan detail spesifikasi setiap ruangan perkuliahan.
	•	Menampilkan status keterisian ruangan saat ini beserta jadwal yang sedang berlangsung.

C. Sistem Penjadwalan & Booking
	•	Form pemesanan ruangan dengan input tanggal, jam mulai, dan jam selesai.
	•	Validasi Konflik: Sistem backend otomatis menolak pemesanan jika jadwal bertabrakan dengan data yang sudah ada di database.
	•	Fitur “Kosongkan Ruangan” untuk mengubah status ruangan menjadi tersedia jika kelas batal secara mendadak.

5. Spesifikasi Teknis (Tech Stack)
	•	Backend: Node.js & Express.js (REST API).
	•	Mobile App: Flutter (Cross-platform Android/iOS).
	•	Database: PostgreSQL (Relational Database).
	•	Real-time: WebSockets (Socket.io) untuk pembaruan status ruangan tanpa refresh manual.