import 'package:intl/intl.dart';

class TestResult {
  String id;
  String namaParticipant;
  String jenisKelamin;
  String prodi;
  int semester;
  String institusi;
  double tinggiBadan;
  double beratBadan;
  String catatanKesehatan;

  // Test scores
  double lari60;
  int gantung;
  int situp;
  int loncat;
  int lariJauh;

  // Converted scores
  int skorLari60;
  int skorGantung;
  int skorSitup;
  int skorLoncat;
  int skorLariJauh;

  int totalSkor;
  String kategori;

  DateTime tanggalTes;
  DateTime? createdAt;
  DateTime? updatedAt;

  TestResult({
    required this.id,
    required this.namaParticipant,
    required this.jenisKelamin,
    required this.prodi,
    required this.semester,
    required this.institusi,
    required this.tinggiBadan,
    required this.beratBadan,
    required this.catatanKesehatan,
    required this.lari60,
    required this.gantung,
    required this.situp,
    required this.loncat,
    required this.lariJauh,
    required this.skorLari60,
    required this.skorGantung,
    required this.skorSitup,
    required this.skorLoncat,
    required this.skorLariJauh,
    required this.totalSkor,
    required this.kategori,
    required this.tanggalTes,
    this.createdAt,
    this.updatedAt,
  });

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'namaParticipant': namaParticipant,
      'jenisKelamin': jenisKelamin,
      'prodi': prodi,
      'semester': semester,
      'institusi': institusi,
      'tinggiBadan': tinggiBadan,
      'beratBadan': beratBadan,
      'catatanKesehatan': catatanKesehatan,
      'lari60': lari60,
      'gantung': gantung,
      'situp': situp,
      'loncat': loncat,
      'lariJauh': lariJauh,
      'skorLari60': skorLari60,
      'skorGantung': skorGantung,
      'skorSitup': skorSitup,
      'skorLoncat': skorLoncat,
      'skorLariJauh': skorLariJauh,
      'totalSkor': totalSkor,
      'kategori': kategori,
      'tanggalTes': DateFormat('yyyy-MM-dd HH:mm:ss').format(tanggalTes),
      'createdAt': createdAt != null
          ? DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt!)
          : DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      'updatedAt': updatedAt != null
          ? DateFormat('yyyy-MM-dd HH:mm:ss').format(updatedAt!)
          : DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    };
  }

  // Create from Map
  factory TestResult.fromMap(Map<String, dynamic> map) {
    return TestResult(
      id: map['id'] ?? '',
      namaParticipant: map['namaParticipant'] ?? '',
      jenisKelamin: map['jenisKelamin'] ?? '',
      prodi: map['prodi'] ?? '',
      semester: map['semester'] ?? 0,
      institusi: map['institusi'] ?? '',
      tinggiBadan: map['tinggiBadan'] ?? 0.0,
      beratBadan: map['beratBadan'] ?? 0.0,
      catatanKesehatan: map['catatanKesehatan'] ?? '',
      lari60: map['lari60'] ?? 0.0,
      gantung: map['gantung'] ?? 0,
      situp: map['situp'] ?? 0,
      loncat: map['loncat'] ?? 0,
      lariJauh: map['lariJauh'] ?? 0,
      skorLari60: map['skorLari60'] ?? 0,
      skorGantung: map['skorGantung'] ?? 0,
      skorSitup: map['skorSitup'] ?? 0,
      skorLoncat: map['skorLoncat'] ?? 0,
      skorLariJauh: map['skorLariJauh'] ?? 0,
      totalSkor: map['totalSkor'] ?? 0,
      kategori: map['kategori'] ?? '',
      tanggalTes: DateTime.parse(
        map['tanggalTes'] ?? DateTime.now().toIso8601String(),
      ),
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : null,
    );
  }
}
