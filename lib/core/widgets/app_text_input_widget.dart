
import 'package:flutter/material.dart';
import 'package:vet_mkononi/core/constants/app_colors.dart';

class AppTextInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const AppTextInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<AppTextInputWidget> createState() => _AppTextInputWidgetState();
}

class _AppTextInputWidgetState extends State<AppTextInputWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword && _obscureText,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all( 10),
          isDense: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColors.secondary),
          filled: true,
          fillColor: Colors.blueGrey.withOpacity(0.1),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: AppColors.secondary, size: 16,)
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.secondary, size: 16,
            ),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:  BorderSide(color: AppColors.primary.withOpacity(0.4), width: 1.5),
          ),
        ),
      ),
    );
  }
}
