# MAPP-FIT

## Deskripsi Aplikasi

**MAPP-FIT** adalah aplikasi pengukuran dan evaluasi kebugaran jasmani berbasis **Tes Kesegaran Jasmani Indonesia (TKJI)**. Aplikasi ini digunakan untuk membantu pendataan, perhitungan nilai, serta klasifikasi tingkat kebugaran jasmani peserta secara sistematis dan terstandar.

Aplikasi ini ditujukan untuk pengguna dengan rentang **usia 16–58 tahun**, dengan penyesuaian norma tes berdasarkan **jenis kelamin (Putra dan Putri)**.

---

## Dasar Penilaian TKJI

Penilaian pada MAPP-FIT mengacu pada norma resmi **Tes Kesegaran Jasmani Indonesia (TKJI)** yang terdiri dari 5 item tes. Setiap item memiliki satuan pengukuran berbeda (detik, kali, cm, menit:detik) dan akan dikonversi menjadi **nilai (1–5)** sebelum dijumlahkan untuk menentukan kategori kebugaran jasmani fileciteturn0file0.

---

## Tabel 1. Nilai Tes Kesegaran Jasmani Indonesia (TKJI) untuk Putra (Usia 16–19 Tahun)

| Nilai | Lari 60 m (detik) | Gantung Angkat Tubuh (kali) | Baring Duduk (kali) | Loncat Tegak (cm) | Lari 1200 m (menit:detik) |
| ----- | ----------------- | --------------------------- | ------------------- | ----------------- | ------------------------- |
| 5     | < 7,2             | > 19                        | > 41                | > 73              | < 3’14”                   |
| 4     | 7,3 – 8,3         | 14 – 18                     | 30 – 40             | 60 – 72           | 3’15” – 4’25”             |
| 3     | 8,4 – 9,6         | 9 – 13                      | 21 – 29             | 50 – 59           | 4’26” – 5’12”             |
| 2     | 9,7 – 11,0        | 5 – 8                       | 10 – 20             | 39 – 49           | 5’13” – 6’33”             |
| 1     | > 11,1            | 0 – 4                       | 0 – 9               | < 38              | > 6’34”                   |

---

## Tabel 2. Nilai Tes Kesegaran Jasmani Indonesia (TKJI) untuk Putri (Usia 16–19 Tahun)

| Nilai | Lari 60 m (detik) | Gantung Angkat Tubuh (kali) | Baring Duduk (kali) | Loncat Tegak (cm) | Lari 1000 m (menit:detik) |
| ----- | ----------------- | --------------------------- | ------------------- | ----------------- | ------------------------- |
| 5     | < 8,4             | > 40                        | > 29                | > 50              | < 3’52”                   |
| 4     | 8,5 – 9,8         | 20 – 39                     | 20 – 28             | 39 – 49           | 3’53” – 4’56”             |
| 3     | 9,9 – 11,4        | 8 – 19                      | 10 – 19             | 31 – 38           | 4’57” – 5’58”             |
| 2     | 11,5 – 13,4       | 2 – 7                       | 3 – 9               | 23 – 30           | 5’59” – 7’23”             |
| 1     | > 13,5            | 0 – 2                       | 0 – 2               | < 23              | > 7’23”                   |

---

## Perbedaan Aturan Tes Putra dan Putri

### 1. Tes Gantung

* **Putra**: Peserta mengangkat tubuh sebanyak mungkin selama **1 menit** (satuan: kali).
* **Putri**: Peserta **menahan posisi menggantung** selama mungkin (satuan: detik).

> Pada aplikasi, field input tes gantung **dibedakan otomatis** berdasarkan jenis kelamin peserta.

### 2. Tes Lari Jarak Menengah

* **Putra**: Lari **1200 meter**.
* **Putri**: Lari **1000 meter**.

> Satuan waktu tetap sama (menit:detik), perbedaannya hanya pada jarak tempuh.

---

## Alur Penilaian di Aplikasi

1. Peserta mengisi biodata (nama, usia, jenis kelamin, tinggi, berat badan, dll).
2. Peserta melakukan 5 item tes TKJI.
3. Hasil mentah dikonversi menjadi nilai (1–5) sesuai tabel norma.
4. Seluruh nilai dijumlahkan.
5. Skor total menentukan **kategori kebugaran jasmani**.

---

## Kategori Tingkat Kesegaran Jasmani

| Jumlah Nilai | Klasifikasi   | Kategori |
| ------------ | ------------- | -------- |
| 22 – 25      | Baik Sekali   | BS       |
| 18 – 21      | Baik          | B        |
| 14 – 17      | Sedang        | S        |
| 10 – 13      | Kurang        | K        |
| 5 – 9        | Kurang Sekali | KS       |

---


**MAPP-FIT** dikembangkan sebagai solusi digital untuk membantu evaluasi kebugaran jasmani secara objektif, terstandar, dan mudah digunakan.
