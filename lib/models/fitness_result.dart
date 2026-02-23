class FitnessResult {
  static int konversiLari60(double detik, String gender) {
    if (gender == 'Putra') { // Tabel 1 
      if (detik < 7.2) return 5;
      if (detik <= 8.3) return 4;
      if (detik <= 9.6) return 3;
      if (detik <= 11.0) return 2;
      return 1;
    } else { // Tabel 2 
      if (detik < 8.4) return 5;
      if (detik <= 9.8) return 4;
      if (detik <= 11.4) return 3;
      if (detik <= 13.4) return 2;
      return 1;
    }
  }

  static int konversiGantung(double kali, String gender) {
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

  static String getKategori(int total) { // Tabel 3 [cite: 33]
    if (total >= 22) return "Baik Sekali (BS)";
    if (total >= 18) return "Baik (B)";
    if (total >= 14) return "Sedang (S)";
    if (total >= 10) return "Kurang (K)";
    return "Kurang Sekali (KS)";
  }
}