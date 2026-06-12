import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF12031E);

  static const Color backgroundSecondary = Color(0xFF1A082A);

  static const Color primary = Color(0xFFB46CFF);

  static const Color primaryDark = Color(0xFF8A3FFC);

  static const Color online = Color(0xFF34D399);

  static const Color textPrimary = Color(0xFFFFFFFF);

  static const Color textSecondary = Color(0xFFB8B4C7);

  static const Color textMuted = Color(0xFF8E879F);

  static const Color glass = Color(0x1AFFFFFF);

  static const Color glassBorder = Color(0x26FFFFFF);

  static const Color shadow = Color(0x66000000);

  static const LinearGradient backgroundGradient =
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2D0A45),
          Color(0xFF1A082A),
          Color(0xFF12031E),
        ],
      );

  static const LinearGradient primaryGradient =
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFC084FC),
          Color(0xFFA855F7),
          Color(0xFF8B5CF6),
        ],
      );
}