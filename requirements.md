# 📌 Requirements Specification

# Aplikasi Kebugaran Jasmani (Berbasis Tes TKJI)

Dokumen ini menjelaskan kebutuhan sistem (System Requirements), fitur utama, serta bagaimana penerapan fitur sesuai dengan data dan mekanisme Tes Kesegaran Jasmani Indonesia (TKJI).

---

# 1. 📖 Deskripsi Umum Sistem

Aplikasi Kebugaran Jasmani adalah sistem digital yang digunakan untuk:

* Menginput biodata peserta tes
* Menginput hasil Tes Kesegaran Jasmani Indonesia (TKJI)
* Mengkonversi data mentah menjadi nilai standar
* Menghitung total skor kebugaran
* Menentukan kategori kesegaran jasmani secara otomatis
* Menyimpan dan menampilkan riwayat hasil tes

Sistem ini menggantikan proses manual perhitungan TKJI menjadi sistem otomatis dan terstandarisasi.

---

# 2. 🎯 Tujuan Sistem

1. Mempermudah proses pencatatan hasil tes kebugaran.
2. Mengurangi kesalahan perhitungan manual.
3. Menghasilkan kategori kebugaran secara otomatis.
4. Menyediakan dokumentasi hasil tes dalam bentuk digital.

---

# 3. 👥 Aktor Sistem

## 3.1 Admin / Penguji

* Menginput data peserta
* Menginput hasil tes
* Melihat hasil dan riwayat

## 3.2 Peserta (Opsional)

* Melihat hasil tes pribadi
* Melihat kategori kebugaran

---

# 4. 🧩 Fitur Sistem dan Penerapannya

## 4.1 Fitur Input Biodata Peserta

### Deskripsi

Sistem menyediakan form untuk menginput biodata peserta sebelum melakukan tes.

### Data yang Diinput

* Nama Lengkap
* Jenis Kelamin (Putra / Putri)
* Program Studi / Jurusan
* Semester
* Institusi
* Tanggal Lahir
* Usia
* Tinggi Badan
* Berat Badan
* Catatan Kesehatan (Sehat / Kurang Fit / Baru Selesai Sakit)

### Penerapan Sistem

* Sistem menyimpan data ke database.
* Jenis kelamin digunakan untuk menentukan tabel norma TKJI yang sesuai.
* Usia digunakan untuk validasi kategori usia (16–19 tahun).

---

## 4.2 Fitur Input Hasil Tes TKJI

### Deskripsi

Sistem menyediakan form input untuk lima komponen tes TKJI.

### Komponen Tes

1. Lari 60 meter (detik)
2. Gantung Angkat Tubuh (jumlah repetisi)
3. Baring Duduk (jumlah repetisi)
4. Loncat Tegak (cm)
5. Lari jarak jauh:

   * 1200 meter (Putra)
   * 1000 meter (Putri)

### Penerapan Sistem

* Sistem menerima data mentah (waktu, jumlah, cm).
* Sistem memvalidasi format input (misal waktu dalam detik atau menit:detik).
* Data mentah disimpan sementara sebelum dikonversi.

---

## 4.3 Fitur Konversi Nilai Otomatis

### Deskripsi

Setiap data mentah akan dikonversi ke nilai 1–5 berdasarkan tabel norma TKJI.

### Mekanisme

* Sistem membaca jenis kelamin.
* Sistem mencocokkan hasil dengan rentang nilai pada tabel norma.
* Sistem memberikan skor (1 sampai 5) untuk setiap item tes.

Contoh:
Jika Lari 60m Putra < 7,2 detik → Nilai 5.

---

## 4.4 Fitur Perhitungan Total Skor

### Deskripsi

Setelah semua nilai dikonversi, sistem akan menghitung total skor.

### Rumus

Total Skor = Nilai1 + Nilai2 + Nilai3 + Nilai4 + Nilai5

Rentang total skor: 5 – 25

---

## 4.5 Fitur Penentuan Kategori Kebugaran

### Deskripsi

Sistem menentukan klasifikasi kesegaran jasmani berdasarkan total skor.

### Kategori

* 22 – 25 → Baik Sekali (BS)
* 18 – 21 → Baik (B)
* 14 – 17 → Sedang (S)
* 10 – 13 → Kurang (K)
* 5 – 9 → Kurang Sekali (KS)

### Penerapan Sistem

* Sistem membaca total skor.
* Sistem mencocokkan dengan tabel norma akhir.
* Sistem menampilkan kategori secara otomatis.

---

## 4.6 Fitur Tampilan Hasil

### Informasi yang Ditampilkan

* Biodata peserta
* Nilai per item
* Total skor
* Kategori kebugaran
* Tanggal tes

### Visualisasi

* Progress bar skor
* Badge warna sesuai kategori
* Ringkasan performa

---

## 4.7 Fitur Riwayat Tes

### Deskripsi

Sistem menyimpan setiap hasil tes dalam database.

### Penerapan

* Setiap tes memiliki ID unik.
* Riwayat dapat difilter berdasarkan nama atau tanggal.
* Data dapat diekspor (opsional PDF).

---

# 5. ⚙️ Kebutuhan Fungsional (Functional Requirements)

1. Sistem harus dapat menyimpan biodata peserta.
2. Sistem harus dapat menerima input hasil tes.
3. Sistem harus dapat mengkonversi nilai secara otomatis.
4. Sistem harus dapat menghitung total skor.
5. Sistem harus dapat menentukan kategori kebugaran.
6. Sistem harus dapat menyimpan riwayat tes.
7. Sistem harus dapat menampilkan hasil secara real-time.

---

# 6. 🔐 Kebutuhan Non-Fungsional (Non-Functional Requirements)

## 6.1 Kinerja

* Perhitungan nilai maksimal 1 detik.

## 6.2 Keamanan

* Data peserta tersimpan aman di database.
* Akses admin menggunakan autentikasi (opsional).

## 6.3 Usability

* Antarmuka sederhana dan mudah digunakan.
* Mobile-first design.

## 6.4 Reliability

* Sistem tidak boleh menghasilkan kategori tanpa semua data terisi.

---

# 7. 🗄️ Kebutuhan Data

## Entitas Utama

### Peserta

* id
* nama
* jenis_kelamin
* usia
* tinggi_badan
* berat_badan
* catatan_kesehatan

### Hasil_Tes

* id
* peserta_id
* nilai_lari_60
* nilai_gantung
* nilai_baring
* nilai_loncat
* nilai_lari_jarak
* total_skor
* kategori
* tanggal_tes

---

# 8. 🔄 Alur Sistem

1. Admin menginput biodata.
2. Admin menginput hasil tes.
3. Sistem melakukan konversi nilai.
4. Sistem menghitung total skor.
5. Sistem menentukan kategori.
6. Sistem menampilkan hasil.
7. Sistem menyimpan data ke database.

---

# 9. 🚀 Pengembangan Lanjutan (Opsional)

* Grafik perkembangan kebugaran.
* Rekomendasi latihan berdasarkan kategori.
* Ekspor laporan PDF.
* Integrasi dengan sistem kampus.

---

✍️ Dokumen ini menjadi dasar pengembangan sistem sebelum masuk ke tahap perancangan database dan implementasi kode.
