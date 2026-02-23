import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/participant.dart';
import '../utils/constants.dart';
import '../widgets/custom_input.dart';
import 'test_input_screen.dart';

class BiodataScreen extends StatefulWidget {
  @override
  _BiodataScreenState createState() => _BiodataScreenState();
}

class _BiodataScreenState extends State<BiodataScreen> {
  final _formKey = GlobalKey<FormState>();

  String nama = '';
  String jenisKelamin = 'Putra';
  String prodi = '';
  int semester = 1;
  String institusi = '';
  int usia = 0;
  double tinggiBadan = 0;
  double beratBadan = 0;
  String catatanKesehatan = 'Sehat';
  DateTime? tanggalLahir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biodata Peserta',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Data Pribadi
              _buildSectionHeader('1. Data Pribadi'),
              SizedBox(height: 16),
              CustomInput(
                label: 'Nama Lengkap',
                onChanged: (value) => nama = value,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Nama tidak boleh kosong' : null,
              ),
              SizedBox(height: 12),
              _buildDropdown(
                label: 'Jenis Kelamin',
                value: jenisKelamin,
                items: ['Putra', 'Putri'],
                onChanged: (value) =>
                    setState(() => jenisKelamin = value ?? 'Putra'),
              ),
              SizedBox(height: 12),
              CustomInput(
                label: 'Program Studi / Jurusan (Opsional)',
                onChanged: (value) => prodi = value,
              ),
              SizedBox(height: 12),
              _buildSemesterInput(),

              SizedBox(height: 24),
              // Section 2: Data Institusi
              _buildSectionHeader('2. Data Institusi'),
              SizedBox(height: 16),
              CustomInput(
                label: 'Institusi / Sekolah / Universitas (Opsional)',
                onChanged: (value) => institusi = value,
              ),

              SizedBox(height: 24),
              // Section 3: Data Kesehatan
              _buildSectionHeader('3. Data Kesehatan & Antropometri'),
              SizedBox(height: 16),
              CustomInput(
                label: 'Usia (tahun)',
                type: TextInputType.number,
                onChanged: (value) =>
                    setState(() => usia = int.tryParse(value) ?? 0),
                validator: (value) {
                  int? age = int.tryParse(value ?? '');
                  if (age == null || age <= 0)
                    return 'Usia harus angka positif';
                  if (age < 16 || age > 19)
                    return 'Kategori usia TKJI: 16-19 tahun';
                  return null;
                },
              ),
              SizedBox(height: 12),
              CustomInput(
                label: 'Tinggi Badan (cm)',
                type: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) => tinggiBadan = double.tryParse(value) ?? 0,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Tinggi badan tidak boleh kosong'
                    : null,
              ),
              SizedBox(height: 12),
              CustomInput(
                label: 'Berat Badan (kg)',
                type: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) => beratBadan = double.tryParse(value) ?? 0,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Berat badan tidak boleh kosong'
                    : null,
              ),
              SizedBox(height: 12),
              _buildDropdown(
                label: 'Catatan Kesehatan',
                value: catatanKesehatan,
                items: ['Sehat', 'Kurang Fit', 'Baru Selesai Sakit'],
                onChanged: (value) =>
                    setState(() => catatanKesehatan = value ?? 'Sehat'),
              ),

              SizedBox(height: 32),
              // Button
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
                  onPressed: _submitForm,
                  child: Text(
                    'Lanjut ke Tes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildSemesterInput() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Semester', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (semester > 1) setState(() => semester--);
                      },
                      color: AppColors.primary,
                    ),
                    Text(
                      semester.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (semester < 14) setState(() => semester++);
                      },
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Participant participant = Participant(
        nama: nama,
        jenisKelamin: jenisKelamin,
        prodi: prodi.isEmpty ? null : prodi,
        semester: semester,
        institusi: institusi.isEmpty ? null : institusi,
        tanggalLahir: usia.toString(),
        usia: usia,
        tinggiBadan: tinggiBadan,
        beratBadan: beratBadan,
        catatanKesehatan: catatanKesehatan,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestInputScreen(participant: participant),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field wajib diisi dengan benar')),
      );
    }
  }
}
