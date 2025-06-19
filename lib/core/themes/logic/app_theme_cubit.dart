import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cache/cache_helper.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial());
  bool isThemeIsDark = false;

  changeTheme() {
    isThemeIsDark = !isThemeIsDark;
    CacheHelper.saveData(key: 'AppTheme', value: isThemeIsDark);
    if (isThemeIsDark) {
      emit(AppThemeIsDark());
    } else {
      emit(AppThemeIsLight());
    }
  }

  getTheme() {
    final savedTheme = CacheHelper.getData(key: 'AppTheme');
    if (savedTheme != null) {
      isThemeIsDark = savedTheme;
      if (isThemeIsDark) {
        emit(AppThemeIsDark());
      } else {
        emit(AppThemeIsLight());
      }
    } else {
      // Default to light theme if no theme is saved
      isThemeIsDark = false;
      CacheHelper.saveData(key: 'AppTheme', value: false);
      emit(AppThemeIsLight());
    }
  }
}
