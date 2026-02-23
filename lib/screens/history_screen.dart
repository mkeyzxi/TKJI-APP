import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/test_result.dart';
import '../services/test_result_service.dart';
import '../utils/constants.dart';
import 'biodata_screen.dart';
import 'test_detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<TestResult>> _testResults;
  String _searchQuery = '';
  String _sortBy = 'date'; // 'date' or 'skor'

  @override
  void initState() {
    super.initState();
    _loadTestResults();
  }

  void _loadTestResults() {
    setState(() {
      _testResults = _searchQuery.isEmpty
          ? TestResultService.getAllTestResults()
          : TestResultService.getTestResultsByName(_searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Tes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search dan Sort
          _buildSearchAndSort(),
          // List Results
          Expanded(
            child: FutureBuilder<List<TestResult>>(
              future: _testResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final results = snapshot.data ?? [];

                if (results.isEmpty) {
                  return _buildEmptyState();
                }

                // Sort results
                if (_sortBy == 'date') {
                  results.sort((a, b) => b.tanggalTes.compareTo(a.tanggalTes));
                } else if (_sortBy == 'skor') {
                  results.sort((a, b) => b.totalSkor.compareTo(a.totalSkor));
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    return _buildResultItem(context, results[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BiodataScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchAndSort() {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Field
          TextField(
            onChanged: (value) {
              _searchQuery = value;
              _loadTestResults();
            },
            decoration: InputDecoration(
              hintText: 'Cari nama peserta...',
              prefixIcon: Icon(Icons.search, color: AppColors.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
          SizedBox(height: 12),
          // Sort Options
          Row(
            children: [
              Text('Urutkan:', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(width: 12),
              Expanded(
                child: SegmentedButton<String>(
                  segments: [
                    ButtonSegment(
                      value: 'date',
                      label: Text('Terbaru'),
                      icon: Icon(Icons.calendar_today),
                    ),
                    ButtonSegment(
                      value: 'skor',
                      label: Text('Skor Tertinggi'),
                      icon: Icon(Icons.trending_up),
                    ),
                  ],
                  selected: {_sortBy},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() => _sortBy = newSelection.first);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      return states.contains(WidgetState.selected)
                          ? AppColors.primary
                          : Colors.transparent;
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      return states.contains(WidgetState.selected)
                          ? Colors.white
                          : AppColors.primary;
                    }),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            'Belum ada riwayat tes',
            style: AppTextStyles.subheading.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Mulai tes kebugaran Anda sekarang',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(BuildContext context, TestResult result) {
    Color categoryColor = _getCategoryColor(result.totalSkor);
    String categoryLabel = _getCategoryLabel(result.totalSkor);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestDetailScreen(result: result),
          ),
        ).then((_) => _loadTestResults());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
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
          border: Border(left: BorderSide(color: categoryColor, width: 4)),
        ),
        child: Row(
          children: [
            // Score Badge
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: categoryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${result.totalSkor}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      '/25',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.namaParticipant,
                    style: AppTextStyles.subheading,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${result.prodi} • Sem ${result.semester}',
                    style: AppTextStyles.caption,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        DateFormat('dd MMM yyyy').format(result.tanggalTes),
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Category Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                categoryLabel,
                style: TextStyle(
                  color: categoryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(int totalSkor) {
    if (totalSkor >= 22) return AppColors.baik_sekali;
    if (totalSkor >= 18) return AppColors.baik;
    if (totalSkor >= 14) return AppColors.sedang;
    if (totalSkor >= 10) return AppColors.kurang;
    return AppColors.kurang_sekali;
  }

  String _getCategoryLabel(int totalSkor) {
    if (totalSkor >= 22) return 'BS';
    if (totalSkor >= 18) return 'B';
    if (totalSkor >= 14) return 'S';
    if (totalSkor >= 10) return 'K';
    return 'KS';
  }
}
