import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: h4.copyWith(color: AppColors.textHint, fontSize: 14.sp),
        contentPadding: EdgeInsets.all(16.r),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.txtInputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.txtInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
