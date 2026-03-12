import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/test_result.dart';
import '../services/test_result_service.dart';
import '../utils/constants.dart';

class TestDetailScreen extends StatefulWidget {
  final TestResult result;

  TestDetailScreen({required this.result});

  @override
  _TestDetailScreenState createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  late Color categoryColor;

  @override
  void initState() {
    super.initState();
    categoryColor = _getCategoryColor(widget.result.totalSkor);
  }

  @override
  Widget build(BuildContext context) {
    String shortKategori = _getShortKategori();
    String tanggalFormatted = DateFormat(
      'dd MMMM yyyy HH:mm',
    ).format(widget.result.tanggalTes);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Hasil Tes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: _showDeleteDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Result Header
            _buildResultHeader(shortKategori),
            SizedBox(height: 24),

            // Biodata
            _buildSection('Biodata Peserta', [
              _buildDetailRow('Nama', widget.result.namaParticipant),
              _buildDetailRow('Jenis Kelamin', widget.result.jenisKelamin),
              _buildDetailRow('Program Studi', widget.result.prodi),
              _buildDetailRow('Semester', '${widget.result.semester}'),
              _buildDetailRow('Institusi', widget.result.institusi),
              _buildDetailRow(
                'Tinggi Badan',
                '${widget.result.tinggiBadan} cm',
              ),
              _buildDetailRow('Berat Badan', '${widget.result.beratBadan} kg'),
              _buildDetailRow(
                'Catatan Kesehatan',
                widget.result.catatanKesehatan,
              ),
            ]),
            SizedBox(height: 20),

            // Scores
            _buildSection('Nilai Komponen Tes', [
              _buildScoreDetail(
                'Lari 60 Meter',
                widget.result.skorLari60,
                '${widget.result.lari60.toStringAsFixed(2)} detik',
              ),
              _buildScoreDetail(
                'Gantung Angkat Tubuh',
                widget.result.skorGantung,
                '${widget.result.gantung} kali',
              ),
              _buildScoreDetail(
                'Baring Duduk (Sit-up)',
                widget.result.skorSitup,
                '${widget.result.situp} kali',
              ),
              _buildScoreDetail(
                'Loncat Tegak',
                widget.result.skorLoncat,
                '${widget.result.loncat} cm',
              ),
              _buildScoreDetail(
                'Lari Jarak Jauh',
                widget.result.skorLariJauh,
                '${(widget.result.lariJauh ~/ 60)} m ${(widget.result.lariJauh % 60)} s',
              ),
            ]),
            SizedBox(height: 20),

            // Summary
            _buildSection('Ringkasan', [
              _buildDetailRow('Total Skor', '${widget.result.totalSkor} / 25'),
              _buildDetailRow('Kategori', widget.result.kategori),
              _buildDetailRow('Tanggal Tes', tanggalFormatted),
            ]),
            SizedBox(height: 24),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Kembali',
                  style: AppTextStyles.heading2.copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildResultHeader(String shortKategori) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: categoryColor, width: 3),
      ),
      child: Column(
        children: [
          Text(
            'Total Skor',
            style: AppTextStyles.bodyText.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '${widget.result.totalSkor} / 25',
            style: AppTextStyles.heading1.copyWith(
              fontSize: 48,
              color: categoryColor,
            ),
          ),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: widget.result.totalSkor / 25,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(categoryColor),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  'Kategori',
                  style: AppTextStyles.caption.copyWith(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  shortKategori,
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.result.kategori,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.subheading),
          SizedBox(height: 16),
          ...children.asMap().entries.map((e) {
            bool isLast = e.key == children.length - 1;
            return Column(
              children: [e.value, if (!isLast) Divider(height: 16)],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildScoreDetail(String label, int score, String value) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodyText.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(value, style: AppTextStyles.caption),
            ],
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getScoreColor(score),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '$score',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Hasil Tes?'),
          content: Text('Apakah Anda yakin ingin menghapus hasil tes ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                await TestResultService.deleteTestResult(widget.result.id);
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Hasil tes dihapus')));
              },
              child: Text('Hapus', style: TextStyle(color: AppColors.error)),
            ),
          ],
        );
      },
    );
  }

  Color _getCategoryColor(int totalSkor) {
    if (totalSkor >= 22) return AppColors.baik_sekali;
    if (totalSkor >= 18) return AppColors.baik;
    if (totalSkor >= 14) return AppColors.sedang;
    if (totalSkor >= 10) return AppColors.kurang;
    return AppColors.kurang_sekali;
  }

  String _getShortKategori() {
    if (widget.result.totalSkor >= 22) return 'BS';
    if (widget.result.totalSkor >= 18) return 'B';
    if (widget.result.totalSkor >= 14) return 'S';
    if (widget.result.totalSkor >= 10) return 'K';
    return 'KS';
  }

  Color _getScoreColor(int score) {
    switch (score) {
      case 5:
        return AppColors.baik_sekali;
      case 4:
        return AppColors.baik;
      case 3:
        return AppColors.sedang;
      case 2:
        return AppColors.kurang;
      default:
        return AppColors.kurang_sekali;
    }
  }
}
