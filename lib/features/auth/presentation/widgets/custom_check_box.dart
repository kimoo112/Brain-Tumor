import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: AppColors.primaryColor,
        value: value,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(
          color: AppColors.darkGrey,
        ),
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          
          });
        });
  }
}
