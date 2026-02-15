# Backend Requirements — RuangSaku

Dokumen ini berisi catatan seluruh endpoint dan fungsionalitas backend yang dibutuhkan oleh frontend Flutter RuangSaku.

---

## 1. Autentikasi (Auth)

### `POST /api/auth/login`
Login pengguna dengan SSO/email dan password.

**Request Body:**
```json
{
  "email": "nim@student.univ.ac.id",
  "password": "string"
}
```

**Response:**
```json
{
  "token": "jwt_token",
  "user": {
    "id": 1,
    "name": "Nama Mahasiswa",
    "email": "nim@student.univ.ac.id",
    "role": "mahasiswa", // "admin" | "dosen" | "mahasiswa"
    "avatar_url": "https://..."
  }
}
```

### `POST /api/auth/register`
Daftar akun baru (jika diperlukan).

### `GET /api/auth/me`
Ambil profil pengguna dari token JWT.

---

## 2. Gedung (Buildings)

### `GET /api/buildings`
Daftar semua gedung beserta jumlah ruangan.

**Response:**
```json
[
  {
    "id": 1,
    "name": "Teknik",
    "icon": "cpu",
    "room_count": 12,
    "color": "#FFF1F2"
  }
]
```

### `GET /api/buildings/:id/rooms`
Daftar ruangan dalam satu gedung.

---

## 3. Ruangan (Rooms)

### `GET /api/rooms`
Daftar semua ruangan (mendukung query params untuk filter/search).

**Query Params:**
- `search` — cari berdasarkan nama/kode ruang
- `building_id` — filter berdasarkan gedung
- `available` — `true` untuk hanya ruang yang tersedia
- `page`, `limit` — pagination

**Response:**
```json
[
  {
    "id": 101,
    "name": "Lab Robotik",
    "building": "Teknik",
    "floor": 2,
    "image_url": "https://...",
    "capacity": 30,
    "facilities": ["Smart TV", "AC", "Proyektor"],
    "wifi_speed": "1 Gbps",
    "is_available": true,
    "current_schedule": null
  }
]
```

### `GET /api/rooms/:id`
Detail ruangan beserta jadwal hari ini.

**Response:**
```json
{
  "id": 101,
  "name": "Lab Robotik",
  "building": "Teknik",
  "floor": 2,
  "image_url": "https://...",
  "capacity": 30,
  "facilities": ["Smart TV", "AC"],
  "wifi_speed": "1 Gbps",
  "is_available": true,
  "today_schedules": [
    {
      "id": 1,
      "start_time": "08:00",
      "end_time": "10:00",
      "booked_by": "Dr. Budi",
      "title": "Kuliah Robotika"
    }
  ]
}
```

### `GET /api/rooms/popular`
Daftar ruangan populer/rekomendasi untuk halaman home.

---

## 4. Booking / Pemesanan

### `POST /api/bookings`
Buat pemesanan ruangan baru. Backend harus melakukan **validasi konflik jadwal**.

**Request Body:**
```json
{
  "room_id": 101,
  "date": "2026-02-17",
  "start_time": "08:00",
  "end_time": "10:00",
  "title": "Diskusi Kelompok" // opsional
}
```

**Response Sukses:**
```json
{
  "id": 10,
  "room_id": 101,
  "room_name": "Lab Robotik",
  "date": "2026-02-17",
  "start_time": "08:00",
  "end_time": "10:00",
  "status": "Active",
  "created_at": "2026-02-16T00:50:00Z"
}
```

**Response Konflik (409):**
```json
{
  "error": "SCHEDULE_CONFLICT",
  "message": "Jadwal bertabrakan dengan pemesanan lain pada 08:00 - 10:00"
}
```

### `GET /api/bookings/me`
Daftar pemesanan milik pengguna yang sedang login.

**Query Params:**
- `status` — `Active` | `Upcoming` | `Completed` | `Cancelled`

**Response:**
```json
[
  {
    "id": 10,
    "room_name": "Lab Robotik",
    "date": "2026-02-18",
    "start_time": "09:00",
    "end_time": "12:00",
    "status": "Active"
  }
]
```

### `DELETE /api/bookings/:id`
Batalkan / kosongkan pemesanan (fitur "Kosongkan Ruangan").

### `PATCH /api/bookings/:id/cancel`
Alternatif soft-cancel: ubah status menjadi `Cancelled`.

---

## 5. Real-time (WebSocket)

### `ws://server/socket`
Koneksi WebSocket menggunakan Socket.io untuk update real-time.

**Events yang dibutuhkan:**

| Event | Arah | Deskripsi |
|---|---|---|
| `room:status_update` | Server → Client | Status ruangan berubah (terisi/kosong) |
| `booking:created` | Server → Client | Ada pemesanan baru |
| `booking:cancelled` | Server → Client | Pemesanan dibatalkan |

**Payload `room:status_update`:**
```json
{
  "room_id": 101,
  "is_available": false,
  "current_schedule": {
    "title": "Kuliah Robotika",
    "end_time": "10:00"
  }
}
```

---

## 6. Kebutuhan Middleware

| Middleware | Keterangan |
|---|---|
| JWT Auth | Semua endpoint kecuali `/auth/login` dan `/auth/register` |
| RBAC | Admin: CRUD gedung/ruangan/user. Dosen: booking + cancel. Mahasiswa: booking saja |
| Rate Limiter | Proteksi endpoint booking dari spam |
| Conflict Validator | Cek tabrakan jadwal sebelum insert booking |

---

## 7. Database Tables (PostgreSQL)

```sql
-- users
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(20) DEFAULT 'mahasiswa', -- admin | dosen | mahasiswa
  avatar_url TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- buildings
CREATE TABLE buildings (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  icon VARCHAR(50),
  color VARCHAR(20)
);

-- rooms
CREATE TABLE rooms (
  id SERIAL PRIMARY KEY,
  building_id INT REFERENCES buildings(id),
  name VARCHAR(100) NOT NULL,
  floor INT,
  capacity INT,
  image_url TEXT,
  facilities TEXT[], -- array PostgreSQL
  wifi_speed VARCHAR(20),
  is_available BOOLEAN DEFAULT TRUE
);

-- bookings
CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  room_id INT REFERENCES rooms(id),
  user_id INT REFERENCES users(id),
  date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  title VARCHAR(200),
  status VARCHAR(20) DEFAULT 'Active', -- Active | Upcoming | Completed | Cancelled
  created_at TIMESTAMP DEFAULT NOW(),
  CONSTRAINT no_overlap EXCLUDE USING gist (
    room_id WITH =,
    date WITH =,
    tsrange(start_time::timestamp, end_time::timestamp) WITH &&
  )
);
```

---

## 8. Tech Stack Backend (sesuai PRD)

- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: PostgreSQL
- **Auth**: JWT (jsonwebtoken)
- **Real-time**: Socket.io
- **ORM (opsional)**: Prisma / Knex.js
