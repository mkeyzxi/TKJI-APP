import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/participant.dart';
import '../models/test_result.dart';
import '../models/tkji_logic.dart';
import '../services/test_result_service.dart';
import '../utils/constants.dart';

class ResultScreen extends StatelessWidget {
  final Participant participant;
  final double lari60;
  final int gantung;
  final int situp;
  final int loncat;
  final int lariJauh;

  ResultScreen({
    required this.participant,
    required this.lari60,
    required this.gantung,
    required this.situp,
    required this.loncat,
    required this.lariJauh,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate scores
    int score1 = TKJILogic.skorLari60(lari60, participant.jenisKelamin);
    int score2 = TKJILogic.skorGantung(gantung, participant.jenisKelamin);
    int score3 = TKJILogic.skorSitUp(situp, participant.jenisKelamin);
    int score4 = TKJILogic.skorLoncat(loncat, participant.jenisKelamin);
    int score5 = TKJILogic.skorLariJauh(lariJauh, participant.jenisKelamin);

    int totalScore = TKJILogic.hitungTotalSkor(
      score1,
      score2,
      score3,
      score4,
      score5,
    );
    String kategori = TKJILogic.getKlasifikasi(totalScore);
    Color kategoriColor = _getKategoriColor(kategori);

    // Build scores variables for use in button callbacks
    final scores = {
      'score1': score1,
      'score2': score2,
      'score3': score3,
      'score4': score4,
      'score5': score5,
      'totalScore': totalScore,
      'kategori': kategori,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hasil TKJI",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Participant Information Card
            _buildParticipantCard(),
            SizedBox(height: 24),

            // Total Score Card
            _buildTotalScoreCard(totalScore, kategori, kategoriColor),
            SizedBox(height: 24),

            // Results Details
            Text("Detail Hasil Tes", style: AppTextStyles.heading2),
            SizedBox(height: 12),
            _buildResultCard(
              "1. Lari 60 Meter",
              "$lari60 detik",
              score1,
              "detik",
            ),
            _buildResultCard(
              "2. Gantung Angkat Tubuh",
              "$gantung kali",
              score2,
              "kali",
            ),
            _buildResultCard(
              "3. Baring Duduk (Sit-up)",
              "$situp kali",
              score3,
              "kali",
            ),
            _buildResultCard("4. Loncat Tegak", "$loncat cm", score4, "cm"),
            _buildResultCard(
              "5. Lari Jarak Jauh",
              "$lariJauh detik",
              score5,
              "detik",
            ),
            SizedBox(height: 24),

            // Score Breakdown
            _buildScoreBreakdown(
              score1,
              score2,
              score3,
              score4,
              score5,
              totalScore,
            ),
            SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary, width: 2),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Kembali",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _saveAndNavigateHome(
                        context,
                        scores['score1'] as int,
                        scores['score2'] as int,
                        scores['score3'] as int,
                        scores['score4'] as int,
                        scores['score5'] as int,
                        scores['totalScore'] as int,
                        scores['kategori'] as String,
                      );
                    },
                    child: Text(
                      "Beranda",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Identitas Peserta", style: AppTextStyles.subheading),
            SizedBox(height: 16),
            _buildInfoRow("Nama", participant.nama),
            Divider(height: 16),
            _buildInfoRow("Usia", "${participant.usia} tahun"),
            Divider(height: 16),
            _buildInfoRow("Jenis Kelamin", participant.jenisKelamin),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalScoreCard(int totalScore, String kategori, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Total Skor TKJI",
            style: AppTextStyles.bodyText.copyWith(color: Colors.white70),
          ),
          SizedBox(height: 12),
          Text(
            "$totalScore",
            style: AppTextStyles.heading1.copyWith(
              color: Colors.white,
              fontSize: 48,
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color, width: 2),
            ),
            child: Text(
              kategori,
              style: AppTextStyles.subheading.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(String test, String result, int score, String unit) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    test,
                    style: AppTextStyles.subheading.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    result,
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    "$score",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "poin",
                    style: TextStyle(fontSize: 10, color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreBreakdown(
    int s1,
    int s2,
    int s3,
    int s4,
    int s5,
    int total,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rincian Skor", style: AppTextStyles.subheading),
            SizedBox(height: 16),
            _buildScoreLine("Lari 60m", s1),
            _buildScoreLine("Gantung", s2),
            _buildScoreLine("Sit-up", s3),
            _buildScoreLine("Loncat", s4),
            _buildScoreLine("Lari Jauh", s5),
            Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "$total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreLine(String label, int score) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14)),
          Text(
            "$score",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }

  Color _getKategoriColor(String kategori) {
    switch (kategori.toUpperCase()) {
      case 'BAIK SEKALI':
        return Colors.green;
      case 'BAIK':
        return Colors.blue;
      case 'SEDANG':
        return Colors.orange;
      case 'KURANG':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _saveAndNavigateHome(
    BuildContext context,
    int score1,
    int score2,
    int score3,
    int score4,
    int score5,
    int totalScore,
    String kategori,
  ) async {
    try {
      final testResult = TestResult(
        id: const Uuid().v4(),
        namaParticipant: participant.nama,
        jenisKelamin: participant.jenisKelamin,
        prodi: participant.prodi ?? '--',
        semester: participant.semester,
        institusi: participant.institusi ?? '--',
        tinggiBadan: participant.tinggiBadan,
        beratBadan: participant.beratBadan,
        catatanKesehatan: participant.catatanKesehatan,
        lari60: lari60,
        gantung: gantung,
        situp: situp,
        loncat: loncat,
        lariJauh: lariJauh,
        skorLari60: score1,
        skorGantung: score2,
        skorSitup: score3,
        skorLoncat: score4,
        skorLariJauh: score5,
        totalSkor: totalScore,
        kategori: kategori,
        tanggalTes: DateTime.now(),
      );

      await TestResultService.saveTestResult(testResult);
      print('Test result saved successfully!');
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      print('Error saving test result: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error menyimpan hasil: $e')));
    }
  }
}
