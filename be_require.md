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
    "name": "Arif Rahman",
    "email": "arif.rahman@univ.ac.id",
    "role": "mahasiswa",
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
Daftar semua gedung beserta jumlah bilik.

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
Daftar bilik dalam satu gedung.

---

## 3. Bilik (Rooms)

### `GET /api/rooms`
Daftar semua bilik (mendukung query params untuk filter/search).

**Query Params:**
- `search` — cari berdasarkan nama/kode bilik
- `building_id` — filter berdasarkan gedung
- `type` — filter berdasarkan jenis: `makmal` | `seminar` | `teori`
- `available` — `true` untuk hanya bilik yang tersedia
- `page`, `limit` — pagination

**Response:**
```json
[
  {
    "id": 101,
    "name": "Makmal Robotik",
    "building": "Gedung Teknik",
    "floor": 2,
    "image_url": "https://...",
    "capacity": 30,
    "facilities": ["Smart TV", "AC", "Proyektor"],
    "wifi_speed": "1 Gbps",
    "is_available": true,
    "status": "ready",
    "is_favorite": false,
    "current_schedule": null
  }
]
```

### `GET /api/rooms/:id`
Detail bilik beserta jadual hari ini.

**Response:**
```json
{
  "id": 101,
  "name": "Makmal Robotik",
  "building": "Gedung Teknik",
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
      "start_time": "08:00",
      "end_time": "10:00",
      "booked_by": "Dr. Budi",
      "title": "Kuliah Robotika"
    }
  ]
}
```

### `GET /api/rooms/:id/time-slots`
Daftar slot masa yang tersedia untuk tarikh tertentu.

**Query Params:**
- `date` — tarikh yang diminta (format: `YYYY-MM-DD`)

**Response:**
```json
[
  { "label": "Pagi", "start_time": "08:00", "end_time": "10:00", "available": true },
  { "label": "Tengahari", "start_time": "11:00", "end_time": "13:00", "available": false },
  { "label": "Petang", "start_time": "14:00", "end_time": "16:00", "available": true }
]
```

---

## 4. Kegemaran (Favorites)

### `GET /api/favorites`
Daftar bilik kegemaran pengguna yang sedang login.

**Response:**
```json
[
  {
    "id": 101,
    "name": "Makmal Robotik",
    "building": "Gedung Teknik",
    "image_url": "https://...",
    "status": "ready"
  }
]
```

### `POST /api/favorites`
Tambah bilik ke senarai kegemaran.

**Request Body:**
```json
{ "room_id": 101 }
```

### `DELETE /api/favorites/:room_id`
Hapus bilik dari senarai kegemaran.

---

## 5. Tempahan (Bookings)

### `POST /api/bookings`
Buat tempahan bilik baru. Backend harus melakukan **validasi konflik jadual**.

**Request Body:**
```json
{
  "room_id": 101,
  "date": "2026-02-17",
  "start_time": "08:00",
  "end_time": "10:00",
  "title": "Diskusi Kumpulan"
}
```

**Response Berjaya:**
```json
{
  "id": 10,
  "room_id": 101,
  "room_name": "Makmal Robotik",
  "date": "2026-02-17",
  "start_time": "08:00",
  "end_time": "10:00",
  "status": "Aktif",
  "created_at": "2026-02-16T00:50:00Z"
}
```

**Response Konflik (409):**
```json
{
  "error": "SCHEDULE_CONFLICT",
  "message": "Jadual bertabrakan dengan tempahan lain pada 08:00 - 10:00"
}
```

### `GET /api/bookings/me`
Daftar tempahan milik pengguna yang sedang login.

**Query Params:**
- `status` — `Aktif` | `Akan Datang` | `Selesai` | `Dibatalkan`

**Response:**
```json
[
  {
    "id": 10,
    "room_name": "Makmal Robotik",
    "date": "2026-02-18",
    "start_time": "09:00",
    "end_time": "12:00",
    "status": "Aktif",
    "status_color": "#10B981",
    "status_bg_color": "#ECFDF5"
  }
]
```

### `DELETE /api/bookings/:id`
Batalkan tempahan.

### `PATCH /api/bookings/:id/cancel`
Alternatif soft-cancel: ubah status menjadi `Dibatalkan`.

---

## 6. Real-time (WebSocket)

### `ws://server/socket`
Koneksi WebSocket menggunakan Socket.io untuk update real-time.

**Events yang dibutuhkan:**

| Event | Arah | Deskripsi |
|---|---|---|
| `room:status_update` | Server → Client | Status bilik berubah (terisi/kosong) |
| `booking:created` | Server → Client | Ada tempahan baru |
| `booking:cancelled` | Server → Client | Tempahan dibatalkan |

**Payload `room:status_update`:**
```json
{
  "room_id": 101,
  "is_available": false,
  "status": "busy",
  "current_schedule": {
    "title": "Kuliah Robotika",
    "end_time": "10:00"
  }
}
```

---

## 7. Kebutuhan Middleware

| Middleware | Keterangan |
|---|---|
| JWT Auth | Semua endpoint kecuali `/auth/login` dan `/auth/register` |
| RBAC | Admin: CRUD gedung/bilik/user. Dosen: tempahan + batal. Mahasiswa: tempahan sahaja |
| Rate Limiter | Proteksi endpoint tempahan dari spam |
| Conflict Validator | Cek pertembungan jadual sebelum insert tempahan |

---

## 8. Database Tables (PostgreSQL)

```sql
-- users
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(20) DEFAULT 'mahasiswa',
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
  facilities TEXT[],
  wifi_speed VARCHAR(20),
  is_available BOOLEAN DEFAULT TRUE,
  status VARCHAR(20) DEFAULT 'ready', -- ready | busy
  type VARCHAR(20) DEFAULT 'seminar' -- makmal | seminar | teori
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
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  title VARCHAR(200),
  status VARCHAR(20) DEFAULT 'Aktif', -- Aktif | Akan Datang | Selesai | Dibatalkan
  created_at TIMESTAMP DEFAULT NOW(),
  CONSTRAINT no_overlap EXCLUDE USING gist (
    room_id WITH =,
    date WITH =,
    tsrange(start_time::timestamp, end_time::timestamp) WITH &&
  )
);

-- time_slots (predefined time slots per room type)
CREATE TABLE time_slots (
  id SERIAL PRIMARY KEY,
  label VARCHAR(50) NOT NULL, -- Pagi | Tengahari | Petang
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  room_type VARCHAR(20) DEFAULT 'seminar'
);
```

---

## 9. Tech Stack Backend (sesuai PRD)

- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: PostgreSQL
- **Auth**: JWT (jsonwebtoken)
- **Real-time**: Socket.io
- **ORM (opsional)**: Prisma / Knex.js
