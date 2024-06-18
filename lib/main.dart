import 'package:brain_tumor/core/cache/cache_helper.dart';
import 'package:brain_tumor/core/utils/bloc_observer.dart';
import 'package:brain_tumor/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:brain_tumor/features/scanner/presentation/logic/cubit/object_detection_cubit.dart';
import 'package:brain_tumor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes/app_router.dart';

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
                create: (context) => AuthCubit(),
              ),
              BlocProvider(
                create: (context) => ObjectDetectionCubit()..loadModel(),
              ),
            ],
            child: MaterialApp.router(
              title: 'Brain Tumor',
              theme: ThemeData(
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: 'Poppins',
                    ),
                useMaterial3: true,
              ),
              routerConfig: router,
            ),
          );
        });
  }
}
