import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/animated_switcher.dart';
import '../../../../core/themes/logic/app_theme_cubit.dart';

class ThemeToggleListTile extends StatelessWidget {
  const ThemeToggleListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        context.read<AppThemeCubit>().isThemeIsDark
            ? CupertinoIcons.moon_circle
            : CupertinoIcons.sun_max_fill,
        color: Theme.of(context).iconTheme.color,
        size: 45,
      ),
      title: Text(
        'Dark Mode',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Text(
        'Enable or disable dark mode',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: DayNightSwitch(
        width: 70,
        height: 70,
        value: context.read<AppThemeCubit>().isThemeIsDark,
        onChanged: (bool value) {
          context.read<AppThemeCubit>().changeTheme();
        },
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }
}
