# 🏃‍♂️ MAPP-FIT

![MAPP-FIT Logo](assets/icon/mapp-fit.png)

## Deskripsi

**MAPP-FIT** adalah aplikasi pengukuran dan evaluasi **Tes Kesegaran Jasmani Indonesia (TKJI)** berbasis Flutter. Aplikasi ini membantu penguji atau institusi untuk mencatat, menghitung, dan mengevaluasi tingkat kebugaran jasmani peserta secara otomatis.

Aplikasi mendukung peserta dengan rentang usia **16–58 tahun** dengan penyesuaian norma berdasarkan **jenis kelamin (Putra / Putri)**.

---

## 🎯 Tujuan

* Mempermudah proses pencatatan hasil tes kebugaran
* Mengurangi kesalahan perhitungan manual
* Menghasilkan kategori kebugaran secara otomatis
* Menyimpan riwayat hasil tes dalam bentuk digital

---

## 🧪 Komponen Tes TKJI

Aplikasi menggunakan standar **Tes Kesegaran Jasmani Indonesia (TKJI)** yang terdiri dari lima item tes:

1. **Lari 60 Meter** – Mengukur kecepatan (detik)
2. **Gantung Angkat Tubuh** – Mengukur kekuatan otot lengan
3. **Baring Duduk (Sit Up)** – Mengukur kekuatan otot perut
4. **Loncat Tegak** – Mengukur daya ledak otot kaki
5. **Lari Jarak Menengah**

   * Putra: 1200 meter
   * Putri: 1000 meter

---

## 📊 Sistem Penilaian

Setiap hasil tes dikonversi menjadi **nilai 1–5** berdasarkan norma TKJI.

Total skor dihitung dari penjumlahan seluruh nilai tes.

Rentang skor: **5 – 25**

---

## 🏅 Kategori Kesegaran Jasmani

| Total Skor | Kategori           |
| ---------- | ------------------ |
| 22 – 25    | Baik Sekali (BS)   |
| 18 – 21    | Baik (B)           |
| 14 – 17    | Sedang (S)         |
| 10 – 13    | Kurang (K)         |
| 5 – 9      | Kurang Sekali (KS) |

---

## ✨ Fitur Utama

### Input Biodata Peserta

* Nama lengkap
* Jenis kelamin
* Program studi
* Semester
* Institusi
* Usia
* Tinggi badan
* Berat badan
* Catatan kesehatan

### Input Hasil Tes

Form untuk memasukkan hasil seluruh tes TKJI.

### Perhitungan Otomatis

Sistem akan:

* Mengkonversi nilai
* Menghitung total skor
* Menentukan kategori kebugaran

### Riwayat Tes

Semua hasil tes disimpan dan dapat dilihat kembali berdasarkan nama peserta atau tanggal tes.

---

## 🗄 Sistem Penyimpanan Data

Aplikasi menggunakan **SQLite** untuk penyimpanan data.

Keuntungan:

* Performa stabil untuk data besar
* Query pencarian cepat
* Penyimpanan data terstruktur

---

## 🎨 Desain Aplikasi

Primary Color:

`#F3882B`

Digunakan untuk tombol utama, progress bar, dan elemen penting dalam aplikasi.

---

## 📱 Struktur Halaman

1. Splash / Welcome Page
2. Halaman Biodata Peserta
3. Halaman Input Tes TKJI
4. Halaman Hasil Tes
5. Halaman Riwayat

---

## 🧱 Teknologi

* Flutter
* Dart
* SQLite (sqflite)
* SharedPreferences

---

## 🚀 Cara Menjalankan Project

### Clone repository

```
git clone https://github.com/username/mapp-fit.git
```

### Masuk ke folder project

```
cd kebugaran
```

### Install dependencies

```
flutter pub get
```

### Jalankan aplikasi

```
flutter run
```

---

## 📂 Struktur Project

```
kebugaran/
 ├── assets/
 │    └── icon/
 │         └── mapp-fit.png
 ├── lib/
 │    ├── models/
 │    ├── services/
 │    ├── screens/
 │    ├── widgets/
 │    ├── utils/
 │    └── main.dart
 └── README.md
```

---

## 🔮 Pengembangan Selanjutnya

* Grafik perkembangan kebugaran
* Export laporan PDF
* Dashboard analitik
* Sistem login pengguna
* Integrasi cloud database
