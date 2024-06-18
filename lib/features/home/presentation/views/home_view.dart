import 'package:brain_tumor/core/utils/app_assets.dart';
import 'package:brain_tumor/core/utils/app_colors.dart';
import 'package:brain_tumor/core/utils/app_text_styles.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../scanner/presentation/logic/cubit/object_detection_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ObjectDetectionCubit, ObjectDetectionState>(
        listener: (context, state) {
          if (state is ObjectDetectionError) {
            CherryToast.error(
              title: Text(state.errMessage),
              animationType: AnimationType.fromTop,
              animationDuration: const Duration(milliseconds: 700),
            ).show(context);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (state is ObjectDetectionInitial ||
                    state is ObjectDetectionModelLoaded)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(Assets.imagesPlusDocument),
                        12.verticalSpace,
                        Text(
                          'You don’t have any documents',
                          style: CustomTextStyles.poppins400Style16,
                        ),
                        8.verticalSpace,
                        Text(
                          'Sync docs across smartphones, tablets, and computers',
                          style: CustomTextStyles.poppins400Style12
                              .copyWith(color: AppColors.darkGrey),
                          textAlign: TextAlign.center,
                        ),
                        16.verticalSpace,
                        Image.asset(Assets.imagesArrowDown),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                if (state is ObjectDetectionLoading)
                  const CircularProgressIndicator(),
                if (state is ObjectDetectionImagePicked ||
                    state is ObjectDetectionDetected)
                  Column(
                    children: [
                      if (state is ObjectDetectionImagePicked)
                        Image.file(
                          state.image,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      if (state is ObjectDetectionDetected)
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                        color:
                                            AppColors.darkGrey.withOpacity(.8))
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  state.image,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(state.recognition,
                                style: CustomTextStyles.poppins400Style20
                                    .copyWith(color: AppColors.primaryColor)),
                          ],
                        ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
//       Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image.asset(Assets.imagesPlusDocument),
//             12.verticalSpace,
//             Text(
//               'You don’t have any documents',
//               style: CustomTextStyles.poppins400Style16,
//             ),
//             8.verticalSpace,
//             Text(
//               'Sync docs across smartphones, tablets, and computers',
//               style: CustomTextStyles.poppins400Style12
//                   .copyWith(color: AppColors.darkGrey),
//               textAlign: TextAlign.center,
//             ),
//             16.verticalSpace,

//             Image.asset(Assets.imagesArrowDown)
//           ],
//         ),
//       ),
//     );
//   }
// }
