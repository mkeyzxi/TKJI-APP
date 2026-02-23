import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFFF3882B); // Oranye sesuai design

  // Secondary & Background
  static const Color secondary = Color(0xFF1F2937); // Biru tua
  static const Color background = Color(0xFFFFFFFF); // Putih
  static const Color surface = Color(0xFFF5F5F5); // Abu-abu muda

  // Text
  static const Color textPrimary = Color(0xFF111827); // Hitam
  static const Color textSecondary = Color(0xFF6B7280); // Abu tua

  // Status
  static const Color success = Color(0xFF22C55E); // Hijau
  static const Color warning = Color(0xFFFACC15); // Kuning
  static const Color error = Color(0xFFEF4444); // Merah

  // Kategori
  static const Color baik_sekali = Color(0xFF22C55E); // Hijau
  static const Color baik = Color(0xFF10B981); // Hijau muda
  static const Color sedang = Color(0xFFFACC15); // Kuning
  static const Color kurang = Color(0xFFF97316); // Oranye
  static const Color kurang_sekali = Color(0xFFEF4444); // Merah
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Poppins',
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
  );
}
