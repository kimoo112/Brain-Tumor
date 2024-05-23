import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final bool isHavePrefix;
  final TextEditingController? controller;
  final IconData? icon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.obscureText,
    this.icon,
    this.suffixIcon,
    this.onChanged,
    this.isHavePrefix = true,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return 'Please enter your ${labelText ?? hintText} ';
            }

            return null;
          },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: isHavePrefix ? Icon(icon, color: AppColors.darkGrey) : null,
        hintStyle: const TextStyle(color: AppColors.darkGrey),
        hintText: hintText,
        label: labelText != null ? Text(labelText!) : null,
        labelStyle: const TextStyle(color: AppColors.darkGrey),
        suffixIcon: suffixIcon,
        hoverColor: AppColors.primaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
