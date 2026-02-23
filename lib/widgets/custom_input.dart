import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final TextInputType type;
  final String? Function(String?)? validator;
  final int maxLines;
  final int minLines;

  const CustomInput({
    required this.label,
    required this.onChanged,
    this.type = TextInputType.text,
    this.validator,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: type,
        maxLines: maxLines,
        minLines: minLines,
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
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
