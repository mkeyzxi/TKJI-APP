import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/custom_input.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String gender = 'Putra';
  double lari60 = 0, gantung = 0, situp = 0, loncat = 0, lariJauh = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Input Nilai TKJI",
          style: AppTextStyles.heading2.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField(
              value: gender,
              items: [
                'Putra',
                'Putri',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => gender = val.toString()),
              decoration: InputDecoration(labelText: "Jenis Kelamin"),
            ),
            CustomInput(
              label: "Lari 60m (Detik)",
              type: TextInputType.number,
              onChanged: (v) => lari60 = double.tryParse(v) ?? 0,
            ),
            CustomInput(
              label: "Gantung Angkat Tubuh (Kali)",
              type: TextInputType.number,
              onChanged: (v) => gantung = double.tryParse(v) ?? 0,
            ),
            CustomInput(
              label: "Baring Duduk (Kali)",
              type: TextInputType.number,
              onChanged: (v) => situp = double.tryParse(v) ?? 0,
            ),
            CustomInput(
              label: "Loncat Tegak (cm)",
              type: TextInputType.number,
              onChanged: (v) => loncat = double.tryParse(v) ?? 0,
            ),
            CustomInput(
              label: gender == 'Putra'
                  ? "Lari Jarak Jauh 1200m (Detik)"
                  : "Lari Jarak Jauh 1000m (Detik)",
              type: TextInputType.number,
              onChanged: (v) => lariJauh = double.tryParse(v) ?? 0,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                // This should navigate to a participant selection or input screen first
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Silakan gunakan Test Input Screen untuk input data TKJI",
                    ),
                  ),
                );
              },
              child: Text(
                "LIHAT HASIL KONVERSI",
                style: AppTextStyles.bodyText.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
