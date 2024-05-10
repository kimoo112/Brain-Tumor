import 'package:brain_tumor/core/cache/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  runApp(const BrainTumor());
}

class BrainTumor extends StatelessWidget {
  const BrainTumor({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            title: 'Brain Tumor',
            theme: ThemeData(
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: 'Poppins',
                  ),
              useMaterial3: true,
            ),
            routerConfig: router,
          );
        });
  }
}
