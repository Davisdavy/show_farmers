
import 'package:flutter/material.dart';
import 'package:vet_mkononi/core/constants/app_colors.dart';

class AppButtonWidget extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final VoidCallback onPressed;
  final bool isPrimary;

  const AppButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 50.0,
    this.width = 100.0,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.primary : Colors.white,
        foregroundColor: isPrimary ? Colors.white : AppColors.primary,
        side: isPrimary ? null : BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
