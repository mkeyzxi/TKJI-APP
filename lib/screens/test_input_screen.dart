import 'package:flutter/material.dart';
import '../models/participant.dart';
import '../utils/constants.dart';
import '../widgets/custom_input.dart';
import 'result_screen.dart';

class TestInputScreen extends StatefulWidget {
  final Participant participant;

  TestInputScreen({required this.participant});

  @override
  _TestInputScreenState createState() => _TestInputScreenState();
}

class _TestInputScreenState extends State<TestInputScreen> {
  int currentStep = 0;

  // Test results
  double lari60 = 0;
  int gantung = 0;
  int situp = 0;
  int loncat = 0;
  int lariJauh = 0;
  int lariJauhDetik = 0;
  int lariJauhMenit = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tes TKJI',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress Indicator
          _buildProgressIndicator(),
          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(key: _formKey, child: _buildStepContent()),
            ),
          ),
          // Navigation Buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(16),
      color: AppColors.surface,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              bool isCompleted = index < currentStep;
              bool isCurrent = index == currentStep;

              return Column(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted || isCurrent
                          ? AppColors.primary
                          : Colors.grey[300],
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isCompleted || isCurrent
                              ? Colors.white
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _getStepLabel(index),
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }),
          ),
          SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (currentStep + 1) / 5,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  String _getStepLabel(int index) {
    switch (index) {
      case 0:
        return 'Lari 60m';
      case 1:
        return 'Gantung';
      case 2:
        return 'Sit-up';
      case 3:
        return 'Loncat';
      case 4:
        return 'Lari Jauh';
      default:
        return '';
    }
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildLari60Step();
      case 1:
        return _buildGantungStep();
      case 2:
        return _buildSitupStep();
      case 3:
        return _buildLoncatStep();
      case 4:
        return _buildLariJauhStep();
      default:
        return SizedBox();
    }
  }

  Widget _buildLari60Step() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(
          'Lari 60 Meter',
          'Catatan: Masukkan hasil dalam detik (s)',
        ),
        SizedBox(height: 24),
        _buildInfoBox(
          'Peserta berlari secepat mungkin menempuh jarak 60 meter.',
        ),
        SizedBox(height: 20),
        CustomInput(
          label: 'Waktu Lari 60m (detik)',
          key: ValueKey('lari60'),
          type: TextInputType.numberWithOptions(decimal: true),
          onChanged: (value) => lari60 = double.tryParse(value) ?? 0,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Waktu tidak boleh kosong';
            double? val = double.tryParse(value!);
            if (val == null || val <= 0) return 'Masukkan angka valid';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildGantungStep() {
    bool isPutra = widget.participant.jenisKelamin == 'Putra';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(
          'Gantung Angkat Tubuh',
          // 2. Sesuaikan catatan header
          isPutra
              ? 'Catatan: Masukkan jumlah repetisi'
              : 'Catatan: Masukkan durasi dalam detik',
        ),
        SizedBox(height: 24),
        // 3. Sesuaikan isi InfoBox sesuai permintaan Anda
        _buildInfoBox(
          isPutra
              ? 'Peserta mengangkat tubuh sebanyak mungkin selama satu menit.'
              : 'Peserta menahan tubuh selama mungkin (hitungan detik).',
        ),
        SizedBox(height: 20),
        CustomInput(
          key: ValueKey(
            'gantung',
          ), // 4. Sesuaikan label input agar user tidak bingung (Kali vs Detik)
          label: isPutra ? 'Jumlah Gantung (kali)' : 'Durasi Menahan (detik)',
          type: TextInputType.number,
          onChanged: (value) => gantung = int.tryParse(value) ?? 0,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Input tidak boleh kosong';
            int? val = int.tryParse(value!);
            if (val == null || val < 0) return 'Masukkan angka valid';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSitupStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(
          'Baring Duduk (Sit-up)',
          'Catatan: Masukkan jumlah repetisi dalam 60 detik',
        ),
        SizedBox(height: 24),
        _buildInfoBox(
          'Peserta tidur telentang dan melakukan sit-up sebanyak mungkin dalam 60 detik.',
        ),
        SizedBox(height: 20),
        CustomInput(
          key: ValueKey('situp'),
          label: 'Jumlah Sit-up (kali)',
          type: TextInputType.number,
          onChanged: (value) => situp = int.tryParse(value) ?? 0,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Jumlah tidak boleh kosong';
            int? val = int.tryParse(value!);
            if (val == null || val < 0) return 'Masukkan angka valid';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLoncatStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader('Loncat Tegak', 'Catatan: Masukkan hasil dalam cm'),
        SizedBox(height: 24),
        _buildInfoBox(
          'Peserta berdiri dan meloncat vertical untuk menjangkau ketinggian maksimal.',
        ),
        SizedBox(height: 20),
        CustomInput(
          key: ValueKey('loncat'),
          label: 'Hasil Loncat Tegak (cm)',
          type: TextInputType.number,
          onChanged: (value) => loncat = int.tryParse(value) ?? 0,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Hasil tidak boleh kosong';
            int? val = int.tryParse(value!);
            if (val == null || val <= 0) return 'Masukkan angka valid';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLariJauhStep() {
    String jarak = widget.participant.jenisKelamin == 'Putra' ? '1200' : '1000';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(
          'Lari Jarak Jauh',
          'Catatan: ${jarak}m untuk ${widget.participant.jenisKelamin}',
        ),
        SizedBox(height: 24),
        _buildInfoBox(
          'Peserta berlari ${jarak} meter secepatnya. Masukkan waktu dalam menit dan detik.',
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomInput(
                key: ValueKey('lariJauhMenit'),
                label: 'Menit',
                type: TextInputType.number,
                onChanged: (value) => setState(
                  () => lariJauhMenit = int.tryParse(value) ?? 0,
                ), // Tambahkan setState agar teks total update otomatis
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Tidak boleh kosong';
                  return null;
                },
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: CustomInput(
                key: ValueKey('lariJauhDetik'),
                label: 'Detik',
                type: TextInputType.number,
                onChanged: (value) => setState(
                  () => lariJauhDetik = int.tryParse(value) ?? 0,
                ), // Tambahkan setState agar teks total update otomatis
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Tidak boleh kosong';
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        // --- PERBAIKAN DI SINI ---
        Container(
          width: double
              .infinity, // Paksa lebar penuh agar sama dengan input di atas
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey[300]!,
            ), // Opsional: tambah border agar lebih tegas
          ),
          child: Text(
            'Total: $lariJauhMenit m $lariJauhDetik s (${lariJauhMenit * 60 + lariJauhDetik} detik)',
            textAlign:
                TextAlign.center, // Buat teks di tengah agar lebih profesional
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.heading2),
        SizedBox(height: 8),
        Text(subtitle, style: AppTextStyles.caption),
      ],
    );
  }

  Widget _buildInfoBox(String text) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: AppTextStyles.bodyText),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () => setState(() => currentStep--),
                child: Text(
                  'Kembali',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (currentStep > 0) SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: _handleNext,
              child: Text(
                currentStep == 4 ? 'Lihat Hasil' : 'Lanjut',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      if (currentStep < 4) {
        setState(() => currentStep++);
      } else {
        // Calculate total score and navigate to result
        _navigateToResult();
      }
    }
  }

  void _navigateToResult() {
    lariJauh = lariJauhMenit * 60 + lariJauhDetik;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          participant: widget.participant,
          lari60: lari60,
          gantung: gantung,
          situp: situp,
          loncat: loncat,
          lariJauh: lariJauh,
        ),
      ),
    );
  }
}
