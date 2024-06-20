
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class ObjectImageWidget extends StatelessWidget {
  const ObjectImageWidget({
    super.key, required this.image,
  });
  final File image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
        BoxShadow(
            blurRadius: 15,
            spreadRadius: 2,
            color: AppColors.darkGrey.withOpacity(.8))
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.file(
          image,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}