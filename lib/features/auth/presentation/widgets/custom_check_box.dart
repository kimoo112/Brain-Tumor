import '../../../../core/cache/cache_helper.dart';
import '../../../../core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/auth_cubit.dart';

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
        value: CacheHelper.getData(key: AppStrings.terms) ?? value,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(
          color: AppColors.darkGrey,
        ),
        onChanged: (newValue) {
          setState(() {
            value = newValue;
            BlocProvider.of<AuthCubit>(context)
                .updateTermsAndConditionCheckBox(newValue: newValue);
            CacheHelper.saveData(key: AppStrings.terms, value: newValue);
          });
        });
  }
}
