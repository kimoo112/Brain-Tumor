import 'package:brain_tumor/core/cache/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial());
  bool isThemeIsDark = false;
  changeTheme() {
    isThemeIsDark = !isThemeIsDark;
    emit(AppThemeChanged());
    CacheHelper.saveData(key: 'AppTheme', value: isThemeIsDark);
    getTheme();
  }

  getTheme() {
    if (CacheHelper.getData(key: 'AppTheme') != null) {
      isThemeIsDark = CacheHelper.getData(key: 'AppTheme');
      if (CacheHelper.getData(key: 'AppTheme') == true) {
        emit(AppThemeIsDark());
      } else {
        emit(AppThemeIsLight());
      }
    }
  }
}
