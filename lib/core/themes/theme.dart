import "../utils/app_colors.dart";
import "package:flutter/material.dart";

class MaterialTheme {
  BuildContext context;
  MaterialTheme(
    this.context,
  );

  static ColorScheme lightScheme() {
    return const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
        surfaceTint: Color(0xff00696e),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xff9cf0f6),
        onPrimaryContainer: Color(0xff002022),
        secondary: Color(0xff4a6364),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xffcce8e9),
        onSecondaryContainer: Color(0xff041f21),
        tertiary: Color(0xff4e5f7d),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: AppColors.primaryBlue,
        onTertiaryContainer: Color(0xff081c36),
        error: Color(0xffba1a1a),
        onError: Color(0xffffffff),
        errorContainer: Color(0xffffdad6),
        onErrorContainer: Color(0xff410002),
        surface: Color(0xfff4fafa),
        onSurface: Color(0xff161d1d),
        onSurfaceVariant: Color(0xff3f4949),
        outline: Color(0xff6f7979),
        outlineVariant: Color(0xffbec8c9),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff2b3232),
        inversePrimary: Color(0xff80d4da),
        background: Color(0xFFF5FDFD),
        onBackground: Color(0xff00696e));
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryLight,
      surfaceTint: Color(0xff80d4da),
      onPrimary: Color(0xff003739),
      primaryContainer: Color(0xff004f53),
      onPrimaryContainer: Color(0xff9cf0f6),
      secondary: Color(0xffb1cccd),
      onSecondary: Color(0xff1b3436),
      secondaryContainer: Color(0xff324b4d),
      onSecondaryContainer: Color(0xffcce8e9),
      tertiary: Color(0xffb6c7e9),
      onTertiary: Color(0xff20314c),
      tertiaryContainer: AppColors.primaryLightBlue,
      onTertiaryContainer: Color(0xffd6e3ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdde4e4),
      onSurfaceVariant: Color(0xffbec8c9),
      outline: Color(0xff899393),
      outlineVariant: Color(0xff3f4949),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e4),
      inversePrimary: Color(0xff00696e),
      background: Color(0xFF050F0F),
      onBackground: Color(0xff80d4da),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        cardColor: colorScheme.tertiaryContainer,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Poppins', bodyColor: colorScheme.inverseSurface),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
