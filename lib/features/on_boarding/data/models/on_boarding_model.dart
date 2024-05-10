import '../../../../core/utils/app_assets.dart';

class OnBoardingModel {
  final String imagePath;
  final String subTitle;
  final String title;

  OnBoardingModel({
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });
}

List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    imagePath: Assets.imagesOnboarding1,
   title: 'Brain',
    subTitle:
        "What makes us superior in this aspect is the use of the latest specialized technology in the detection of brain tumors",
    
  ),
  OnBoardingModel(
    imagePath: Assets.imagesOnboarding2,
   title: 'Feature Of Scanner',
    subTitle:
        "Where you can access the best rumor detection without any doubt of getting incorrect information",
  ),
  OnBoardingModel(
    imagePath: Assets.imagesOnboarding3,
   title: 'Oncology Checker Application',
    subTitle:
        "You will find here what you're for And we hope to be at your best",
  ),
];
