class TKJILogic {
  // 1. Konversi Lari 60 Meter [cite: 23, 27]
  static int skorLari60(double detik, String gender) {
    if (gender == 'Putra') {
      if (detik < 7.2) return 5;
      if (detik <= 8.3) return 4;
      if (detik <= 9.6) return 3;
      if (detik <= 11.0) return 2;
      return 1;
    } else {
      if (detik < 8.4) return 5;
      if (detik <= 9.8) return 4;
      if (detik <= 11.4) return 3;
      if (detik <= 13.4) return 2;
      return 1;
    }
  }

  // 2. Konversi Gantung Angkat Tubuh [cite: 23, 27]
  static int skorGantung(int kali, String gender) {
    if (gender == 'Putra') {
      if (kali > 19) return 5;
      if (kali >= 14) return 4;
      if (kali >= 9) return 3;
      if (kali >= 5) return 2;
      return 1;
    } else {
      if (kali > 40) return 5;
      if (kali >= 20) return 4;
      if (kali >= 8) return 3;
      if (kali >= 2) return 2;
      return 1;
    }
  }

  // 3. Konversi Baring Duduk / Sit Up [cite: 23, 27]
  static int skorSitUp(int kali, String gender) {
    if (gender == 'Putra') {
      if (kali > 41) return 5;
      if (kali >= 30) return 4;
      if (kali >= 21) return 3;
      if (kali >= 10) return 2;
      return 1;
    } else {
      if (kali > 29) return 5;
      if (kali >= 20) return 4;
      if (kali >= 10) return 3;
      if (kali >= 3) return 2;
      return 1;
    }
  }

  // 4. Konversi Loncat Tegak [cite: 23, 27]
  static int skorLoncat(int cm, String gender) {
    if (gender == 'Putra') {
      if (cm > 73) return 5;
      if (cm >= 60) return 4;
      if (cm >= 50) return 3;
      if (cm >= 39) return 2;
      return 1;
    } else {
      if (cm > 50) return 5;
      if (cm >= 39) return 4;
      if (cm >= 31) return 3;
      if (cm >= 23) return 2;
      return 1;
    }
  }

  // 5. Konversi Lari Jarak Jauh (Putra 1200m / Putri 1000m) [cite: 23, 27]
  // Input dalam satuan detik
  static int skorLariJauh(int totalDetik, String gender) {
    if (gender == 'Putra') {
      if (totalDetik < 194) return 5; // < 3'14"
      if (totalDetik <= 265) return 4; // 3'15" - 4'25"
      if (totalDetik <= 312) return 3; // 4'26" - 5'12"
      if (totalDetik <= 393) return 2; // 5'13" - 6'33"
      return 1;
    } else {
      if (totalDetik < 232) return 5; // < 3'52"
      if (totalDetik <= 296) return 4; // 3'53" - 4'56"
      if (totalDetik <= 358) return 3; // 4'57" - 5'58"
      if (totalDetik <= 443) return 2; // 5'59" - 7'23"
      return 1;
    }
  }

  // 6. Penentuan Klasifikasi Akhir [cite: 31, 33]
  static String getKlasifikasi(int totalSkor) {
    if (totalSkor >= 22) return "Baik Sekali (BS)";
    if (totalSkor >= 18) return "Baik (B)";
    if (totalSkor >= 14) return "Sedang (S)";
    if (totalSkor >= 10) return "Kurang (K)";
    return "Kurang Sekali (KS)";
  }

  // 7. Get Kategori Warna
  static String getKategoriColor(int totalSkor) {
    if (totalSkor >= 22) return "baik_sekali";
    if (totalSkor >= 18) return "baik";
    if (totalSkor >= 14) return "sedang";
    if (totalSkor >= 10) return "kurang";
    return "kurang_sekali";
  }

  // 8. Hitung Total Skor
  static int hitungTotalSkor(int s1, int s2, int s3, int s4, int s5) {
    return s1 + s2 + s3 + s4 + s5;
  }
}
