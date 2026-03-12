import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/custom_input.dart';
import 'quick_result_screen.dart';

class QuickCalculateScreen extends StatefulWidget {
  @override
  _QuickCalculateScreenState createState() => _QuickCalculateScreenState();
}

class _QuickCalculateScreenState extends State<QuickCalculateScreen> {
  final _formKey = GlobalKey<FormState>();

  String jenisKelamin = 'Putra';
  int usia = 16;
  double lari60 = 0;
  int gantung = 0;
  int situp = 0;
  int loncat = 0;
  int lariJauh = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hitung Skor TKJI',
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
              // Gender Selection
              Text('Jenis Kelamin', style: AppTextStyles.subheading),
              SizedBox(height: 12),
              DropdownButtonFormField(
                value: jenisKelamin,
                items: ['Putra', 'Putri']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) =>
                    setState(() => jenisKelamin = val.toString()),
                decoration: InputDecoration(
                  labelText: "Jenis Kelamin",
                  labelStyle: AppTextStyles.bodyText.copyWith(
                    color: AppColors.primary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Usia Input
              Text('Data Peserta', style: AppTextStyles.subheading),
              SizedBox(height: 12),
              CustomInput(
                label: "Usia (tahun)",
                type: TextInputType.number,
                onChanged: (v) => usia = int.tryParse(v) ?? 16,
                validator: (value) {
                  int? age = int.tryParse(value ?? '');
                  if (age == null || age <= 0)
                    return 'Usia harus angka positif';
                  if (age < 16 || age > 58)
                    return 'Kategori usia TKJI: 16-58 tahun';
                  return null;
                },
              ),
              SizedBox(height: 24),

              // Test Inputs
              Text('Hasil Tes TKJI', style: AppTextStyles.subheading),
              SizedBox(height: 16),
              CustomInput(
                label: "Lari 60m (Detik)",
                type: TextInputType.numberWithOptions(decimal: true),
                onChanged: (v) => lari60 = double.tryParse(v) ?? 0,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Tidak boleh kosong' : null,
              ),
              SizedBox(height: 12),
              CustomInput(
                label: jenisKelamin == 'Putra'
                    ? "Gantung Angkat Tubuh (Kali)"
                    : "Menahan Tubuh (Detik)",
                type: TextInputType.number,
                onChanged: (v) => gantung = int.tryParse(v) ?? 0,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Tidak boleh kosong' : null,
              ),
              SizedBox(height: 12),
              CustomInput(
                label: "Baring Duduk (Kali)",
                type: TextInputType.number,
                onChanged: (v) => situp = int.tryParse(v) ?? 0,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Tidak boleh kosong' : null,
              ),
              SizedBox(height: 12),
              CustomInput(
                label: "Loncat Tegak (cm)",
                type: TextInputType.number,
                onChanged: (v) => loncat = int.tryParse(v) ?? 0,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Tidak boleh kosong' : null,
              ),
              SizedBox(height: 12),
              CustomInput(
                label: "Lari Jarak Jauh (Detik)",
                type: TextInputType.number,
                onChanged: (v) => lariJauh = int.tryParse(v) ?? 0,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Tidak boleh kosong' : null,
              ),
              SizedBox(height: 32),

              // Submit Button
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
                  onPressed: _handleCalculate,
                  child: Text(
                    'Hitung Skor',
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

  void _handleCalculate() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuickResultScreen(
            jenisKelamin: jenisKelamin,
            usia: usia,
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
}
