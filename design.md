# 📱 Design Aplikasi Kebugaran Jasmani

Dokumen ini berisi panduan desain (UI/UX & struktur visual) untuk aplikasi **Kebugaran Jasmani** berbasis data Tes Kesegaran Jasmani Indonesia (TKJI).

---

## 1. 🎯 Tujuan Desain

* Menyajikan data tes kebugaran secara **jelas, ringkas, dan mudah dipahami**
* Memberikan pengalaman pengguna yang **sederhana, cepat, dan informatif**
* Mendukung penggunaan di **mobile-first** (Android/Web)

---

## 2. 🎨 Identitas Visual

### 2.1 Warna Utama (Primary Color)

| Fungsi  | Warna  | Kode      |
| ------- | ------ | --------- |
| Primary | Oranye | `#F3882B` |

### 2.2 Palet Warna Pendukung

| Kegunaan       | Warna        | Kode      |
| -------------- | ------------ | --------- |
| Secondary      | Biru Tua     | `#1F2937` |
| Background     | Putih        | `#FFFFFF` |
| Surface        | Abu-abu Muda | `#F5F5F5` |
| Text Primary   | Hitam        | `#111827` |
| Text Secondary | Abu Tua      | `#6B7280` |
| Success        | Hijau        | `#22C55E` |
| Warning        | Kuning       | `#FACC15` |
| Error          | Merah        | `#EF4444` |

> 🎯 **Catatan:** Warna `#F3882B` digunakan untuk tombol utama, highlight, progress bar, dan elemen penting.

---

## 3. ✍️ Tipografi

| Elemen     | Font            | Ukuran  |
| ---------- | --------------- | ------- |
| Heading    | Poppins / Inter | 20–24px |
| Subheading | Poppins / Inter | 16–18px |
| Body Text  | Inter / Roboto  | 14–16px |
| Caption    | Inter           | 12px    |

* Font **sans-serif**
* Gunakan **font-weight 600–700** untuk judul

---

## 4. 🧱 Struktur Layout Umum

### 4.1 Layout Dasar

```
Header
-----------------
Content
-----------------
Bottom Navigation
```

### 4.2 Prinsip Layout

* Padding standar: `16px`
* Radius card & button: `8–12px`
* Shadow ringan untuk card
* Scroll vertikal

---

## 5. 🧩 Komponen UI

### 5.1 Button

* **Primary Button**

  * Background: `#F3882B`
  * Text: `#FFFFFF`
  * Radius: `10px`

* **Secondary Button**

  * Border: `#F3882B`
  * Text: `#F3882B`

### 5.2 Card

Digunakan untuk:

* Biodata peserta
* Hasil tes
* Ringkasan nilai

```
+-------------------+
| Judul Card        |
| Isi / Data        |
+-------------------+
```

### 5.3 Input Form

* Label di atas input
* Border default abu-abu
* Focus: border `#F3882B`

---

## 6. 📄 Struktur Halaman

### 6.1 Splash / Welcome Page

* Logo Aplikasi
* Warna dominan `#F3882B`
* Tombol **Mulai Tes**

---

### 6.2 Halaman Biodata Peserta

Form input:

* Nama Lengkap
* Jenis Kelamin
* Program Studi
* Semester
* Institusi
* Usia, Tinggi, Berat
* Catatan Kesehatan

CTA: **Lanjut ke Tes**

---

### 6.3 Halaman Input Tes TKJI

Input per item:

* Lari 60 m
* Gantung Angkat Tubuh
* Baring Duduk
* Loncat Tegak
* Lari (1000 m / 1200 m)

Progress step indicator (1–5)

---

### 6.4 Halaman Hasil Tes

Menampilkan:

* Nilai per item
* Total skor TKJI
* Kategori:

  * Baik Sekali
  * Baik
  * Sedang
  * Kurang
  * Kurang Sekali

Gunakan:

* Badge warna
* Progress bar

---

### 6.5 Halaman Riwayat (Opsional)

* List hasil tes sebelumnya
* Filter berdasarkan tanggal

---

## 7. 📊 Visualisasi Data

* Progress Bar → warna `#F3882B`
* Badge kategori:

  * BS → Hijau
  * B → Hijau Muda
  * S → Kuning
  * K → Oranye
  * KS → Merah

---

## 8. ♿ Aksesibilitas

* Kontras teks minimum WCAG
* Ukuran teks dapat diperbesar
* Button minimal tinggi `44px`

---

## 9. 📱 Responsif & Platform

* Mobile-first
* Breakpoint:

  * Mobile ≤ 640px
  * Tablet ≤ 1024px
  * Desktop > 1024px

---

## 10. 📌 Catatan Pengembangan

* Desain mengikuti prinsip **simple & functional**
* Mudah diimplementasikan di **Web / Android**
* Cocok untuk arsitektur **SPA / MVP**

---

✍️ *Dokumen ini menjadi acuan utama UI/UX sebelum tahap implementasi frontend.*
