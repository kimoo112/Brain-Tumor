
import 'social_media_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';

class ContinueWithSocialMediaButtons extends StatelessWidget {
  const ContinueWithSocialMediaButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaButton(
          image: Assets.imagesGoogleIcon,
        ),
        SocialMediaButton(
          image: Assets.imagesFacebookLogo,
        ),
      ],
    );
  }
}
