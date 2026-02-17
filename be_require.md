# Backend Requirements — RuangSaku V2

Dokumen ini berisi seluruh endpoint dan fungsionalitas backend yang dibutuhkan oleh frontend Flutter RuangSaku.

---

## 1. Autentikasi (Auth)

### `POST /api/auth/login`
Login pengguna dengan NIM/email dan password.

**Request Body:**
```json
{
  "nim_or_email": "434231022",
  "password": "string"
}
```

**Response:**
```json
{
  "token": "jwt_token",
  "user": {
    "id": 1,
    "name": "Abdul Alim",
    "nim": "434231022",
    "email": "alim@student.univ.ac.id",
    "role": "mahasiswa",
    "jurusan": "Teknik Informatika",
    "semester": 6,
    "ipk": 3.85,
    "sks_total": 124,
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
    "room_count": 12
  },
  {
    "id": 2,
    "name": "Ekonomi",
    "icon": "bar-chart-3",
    "room_count": 8
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
- `search` — cari berdasarkan nama ruangan
- `building_id` — filter berdasarkan gedung
- `available` — `true` untuk hanya ruangan yang tersedia
- `page`, `limit` — pagination

**Response:**
```json
[
  {
    "id": 1,
    "name": "OasisOverture",
    "building": "Gedung Teknik",
    "building_id": "T",
    "floor": 2,
    "image_url": "https://...",
    "capacity": 30,
    "facilities": ["Smart TV", "AC", "Proyektor"],
    "wifi_speed": "1 Gbps",
    "is_available": true,
    "status": "ready",
    "is_favorite": false
  }
]
```

### `GET /api/rooms/:id`
Detail ruangan beserta jadual hari ini.

**Response:**
```json
{
  "id": 1,
  "name": "OasisOverture",
  "building": "Gedung Teknik",
  "building_id": "T",
  "floor": 2,
  "image_url": "https://...",
  "capacity": 30,
  "facilities": ["Smart TV", "AC"],
  "wifi_speed": "1 Gbps",
  "is_available": true,
  "status": "ready",
  "is_favorite": true,
  "today_schedules": [
    {
      "id": 1,
      "session": "08:00 - 10:00",
      "booked_by": "Dr. Budi",
      "title": "Kuliah Robotika"
    }
  ]
}
```

### `GET /api/rooms/:id/sessions`
Daftar sesi yang tersedia untuk tanggal tertentu.

**Query Params:**
- `date` — tanggal yang diminta (format: `YYYY-MM-DD`)

**Response:**
```json
[
  { "session": 1, "time": "08:00 - 10:00", "available": true },
  { "session": 2, "time": "10:00 - 12:00", "available": false },
  { "session": 3, "time": "13:00 - 15:00", "available": true },
  { "session": 4, "time": "15:00 - 17:00", "available": true }
]
```

### `GET /api/rooms/:id/validation`
Cek status validasi konflik jadwal untuk tanggal dan sesi tertentu.

**Query Params:**
- `date` — format `YYYY-MM-DD`
- `session` — nomor sesi (1-4)

**Response:**
```json
{
  "valid": true,
  "status": "Bebas Konflik",
  "message": null
}
```

---

## 4. Favorit (Favorites)

### `GET /api/favorites`
Daftar ruangan favorit pengguna yang sedang login.

**Response:**
```json
[
  {
    "id": 1,
    "name": "OasisOverture",
    "building": "Gedung Teknik",
    "image_url": "https://...",
    "status": "ready"
  }
]
```

### `POST /api/favorites`
Tambah ruangan ke daftar favorit.

**Request Body:**
```json
{ "room_id": 1 }
```

### `DELETE /api/favorites/:room_id`
Hapus ruangan dari daftar favorit.

---

## 5. Booking (Pemesanan)

### `POST /api/bookings`
Buat pemesanan ruangan baru. Backend harus melakukan **validasi konflik jadwal**.

**Request Body:**
```json
{
  "room_id": 1,
  "date": "2026-02-17",
  "session": 1,
  "start_time": "08:00",
  "end_time": "10:00"
}
```

**Response Berhasil:**
```json
{
  "id": 774219,
  "room_id": 1,
  "room_name": "OasisOverture",
  "date": "2026-02-17",
  "session": "08:00 - 10:00",
  "status": "Aktif",
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
Daftar pemesanan milik pengguna yang sedang login (riwayat booking).

**Query Params:**
- `status` — `Aktif` | `Akan Datang` | `Selesai` | `Dibatalkan`

**Response:**
```json
[
  {
    "id": 774219,
    "room_id": 1,
    "room_name": "OasisOverture",
    "room_building": "Gedung Teknik • Lt 2",
    "room_image_url": "https://...",
    "date": "2026-02-17",
    "month": "FEB",
    "session": "08:00 - 10:00",
    "status": "Aktif",
    "status_color": "#059669",
    "status_bg_color": "#ECFDF5"
  }
]
```

### `GET /api/bookings/:id`
Detail pemesanan tunggal (untuk halaman Booked Detail).

**Response:**
```json
{
  "id": 774219,
  "room_id": 1,
  "room_name": "OasisOverture",
  "room_building": "Gedung Teknik • Lt 2",
  "room_image_url": "https://...",
  "date": "17",
  "month": "FEB",
  "session": "08:00 - 10:00",
  "status": "Aktif"
}
```

### `PATCH /api/bookings/:id/cancel`
Batalkan pemesanan (soft-cancel: ubah status menjadi `Dibatalkan`).

**Response:**
```json
{
  "id": 774219,
  "status": "Dibatalkan",
  "cancelled_at": "2026-02-17T10:00:00Z"
}
```

---

## 6. Real-time (WebSocket)

### `ws://server/socket`
Koneksi WebSocket menggunakan Socket.io untuk update real-time.

**Events yang dibutuhkan:**

| Event | Arah | Deskripsi |
|---|---|---|
| `room:status_update` | Server → Client | Status ruangan berubah (terisi/kosong) |
| `booking:created` | Server → Client | Ada pemesanan baru |
| `booking:cancelled` | Server → Client | Pemesanan dibatalkan |

---

## 7. Middleware

| Middleware | Keterangan |
|---|---|
| JWT Auth | Semua endpoint kecuali `/auth/login` dan `/auth/register` |
| RBAC | Admin: CRUD gedung/ruangan/user. Dosen: booking + batal. Mahasiswa: booking saja |
| Rate Limiter | Proteksi endpoint booking dari spam |
| Conflict Validator | Cek konflik jadwal sebelum insert booking |

---

## 8. Database Tables (PostgreSQL)

```sql
-- users
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  nim VARCHAR(20) UNIQUE,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(20) DEFAULT 'mahasiswa',
  jurusan VARCHAR(100),
  semester INT DEFAULT 1,
  ipk DECIMAL(3,2) DEFAULT 0.00,
  sks_total INT DEFAULT 0,
  avatar_url TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- buildings
CREATE TABLE buildings (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  icon VARCHAR(50),
  building_code CHAR(1) UNIQUE  -- T, E, H, S, K, M, F, B
);

-- rooms
CREATE TABLE rooms (
  id SERIAL PRIMARY KEY,
  building_id INT REFERENCES buildings(id),
  name VARCHAR(100) NOT NULL,
  floor INT,
  capacity INT,
  image_url TEXT,
  facilities TEXT[],
  wifi_speed VARCHAR(20),
  is_available BOOLEAN DEFAULT TRUE,
  status VARCHAR(20) DEFAULT 'ready' -- ready | busy
);

-- favorites
CREATE TABLE favorites (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  room_id INT REFERENCES rooms(id),
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, room_id)
);

-- bookings
CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  room_id INT REFERENCES rooms(id),
  user_id INT REFERENCES users(id),
  date DATE NOT NULL,
  session_number INT NOT NULL, -- 1-4
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  status VARCHAR(20) DEFAULT 'Aktif', -- Aktif | Akan Datang | Selesai | Dibatalkan
  cancelled_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  CONSTRAINT no_overlap EXCLUDE USING gist (
    room_id WITH =,
    date WITH =,
    tsrange(start_time::timestamp, end_time::timestamp) WITH &&
  )
);

-- sessions (predefined sessions)
CREATE TABLE sessions (
  id SERIAL PRIMARY KEY,
  session_number INT NOT NULL, -- 1, 2, 3, 4
  start_time TIME NOT NULL,
  end_time TIME NOT NULL
);

-- Seed sessions
INSERT INTO sessions VALUES
  (1, 1, '08:00', '10:00'),
  (2, 2, '10:00', '12:00'),
  (3, 3, '13:00', '15:00'),
  (4, 4, '15:00', '17:00');
```

---

## 9. Tech Stack Backend

- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: PostgreSQL
- **Auth**: JWT (jsonwebtoken)
- **Real-time**: Socket.io
- **ORM (opsional)**: Prisma / Knex.js
