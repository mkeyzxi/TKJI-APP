class Participant {
  String nama;
  String jenisKelamin;
  String? prodi;
  int semester;
  String? institusi;
  String tanggalLahir;
  int usia;
  double tinggiBadan;
  double beratBadan;
  String catatanKesehatan;

  Participant({
    required this.nama,
    required this.jenisKelamin,
    this.prodi,
    required this.semester,
    this.institusi,
    required this.tanggalLahir,
    required this.usia,
    required this.tinggiBadan,
    required this.beratBadan,
    required this.catatanKesehatan,
  });
}
