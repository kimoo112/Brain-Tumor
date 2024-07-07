import 'package:brain_tumor/core/themes/logic/app_theme_cubit.dart';
import 'package:brain_tumor/core/themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/cache/cache_helper.dart';
import 'core/routes/app_router.dart';
import 'core/utils/bloc_observer.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/scanner/presentation/logic/cubit/object_detection_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
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
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AppThemeCubit()..getTheme(),
              ),
              BlocProvider(
                create: (context) => AuthCubit(),
              ),
              BlocProvider(
                create: (context) => ObjectDetectionCubit()..loadModel(),
              ),
            ],
            child: BlocBuilder<AppThemeCubit, AppThemeState>(
              builder: (context, state) {
                ThemeMode themeMode;
                if (state is AppThemeIsDark) {
                  themeMode = ThemeMode.dark;
                } else if (state is AppThemeIsLight) {
                  themeMode = ThemeMode.light;
                } else {
                  themeMode = ThemeMode.system;
                }
                return MaterialApp.router(
                  title: 'Brain Tumor',
                  themeMode: themeMode,
                  darkTheme: MaterialTheme(context).dark(),
                  theme: MaterialTheme(context).light(),
                  routerConfig: router,
                );
              },
            ),
          );
        });
  }
}
