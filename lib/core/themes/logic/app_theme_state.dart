part of 'app_theme_cubit.dart';

sealed class AppThemeState {}

final class AppThemeInitial extends AppThemeState {}
final class AppThemeChanged extends AppThemeState {}
final class AppThemeIsDark extends AppThemeState {}
final class AppThemeIsLight extends AppThemeState {}
