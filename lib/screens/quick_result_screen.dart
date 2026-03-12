import 'package:flutter/material.dart';
import '../models/tkji_logic.dart';
import '../utils/constants.dart';

class QuickResultScreen extends StatelessWidget {
  final String jenisKelamin;
  final int usia;
  final double lari60;
  final int gantung;
  final int situp;
  final int loncat;
  final int lariJauh;

  QuickResultScreen({
    required this.jenisKelamin,
    required this.usia,
    required this.lari60,
    required this.gantung,
    required this.situp,
    required this.loncat,
    required this.lariJauh,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate scores
    int score1 = TKJILogic.skorLari60(lari60, jenisKelamin);
    int score2 = TKJILogic.skorGantung(gantung, jenisKelamin);
    int score3 = TKJILogic.skorSitUp(situp, jenisKelamin);
    int score4 = TKJILogic.skorLoncat(loncat, jenisKelamin);
    int score5 = TKJILogic.skorLariJauh(lariJauh, jenisKelamin);

    int totalScore = TKJILogic.hitungTotalSkor(
      score1,
      score2,
      score3,
      score4,
      score5,
    );
    String kategori = TKJILogic.getKlasifikasi(totalScore);
    Color kategoriColor = _getKategoriColor(kategori);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hasil Kalkulasi TKJI",
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
            // Total Score Card
            _buildTotalScoreCard(totalScore, kategori, kategoriColor),
            SizedBox(height: 24),

            // Results Details
            Text("Detail Hasil Tes", style: AppTextStyles.heading2),
            SizedBox(height: 12),
            _buildResultCard("1. Lari 60 Meter", "$lari60 detik", score1),
            _buildResultCard(
              "2. Gantung Angkat Tubuh",
              "$gantung kali",
              score2,
            ),
            _buildResultCard("3. Baring Duduk (Sit-up)", "$situp kali", score3),
            _buildResultCard("4. Loncat Tegak", "$loncat cm", score4),
            _buildResultCard("5. Lari Jarak Jauh", "$lariJauh detik", score5),
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

            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text(
                  "Kembali ke Beranda",
                  style: AppTextStyles.subheading.copyWith(color: Colors.white),
                ),
              ),
            ),
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

  Widget _buildResultCard(String test, String result, int score) {
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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    result,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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

  Color _getKategoriColor(String kategori) {
    String upper = kategori.toUpperCase();
    if (upper.contains('BAIK SEKALI')) {
      return Colors.green;
    } else if (upper.contains('BAIK')) {
      return Colors.blue;
    } else if (upper.contains('SEDANG')) {
      return Colors.orange;
    } else if (upper.contains('KURANG SEKALI')) {
      return Colors.red[900] ?? Colors.red;
    } else if (upper.contains('KURANG')) {
      return Colors.red;
    }
    return Colors.grey;
  }
}
