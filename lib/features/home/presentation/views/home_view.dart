import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../scanner/presentation/logic/cubit/object_detection_cubit.dart';
import '../widgets/empty_documents_widget.dart';
import '../widgets/object_image_widget.dart';

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
                  const EmptyDocumentsWidget(),
                if (state is ObjectDetectionLoading)
                  const CircularProgressIndicator(),
                if (state is ObjectDetectionImagePicked ||
                    state is ObjectDetectionDetected)
                  Column(
                    children: [
                      if (state is ObjectDetectionImagePicked)
                        ObjectImageWidget(
                          image: state.image,
                        ),
                      if (state is ObjectDetectionDetected)
                        Column(
                          children: [
                            ObjectImageWidget(
                              image: state.image,
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
