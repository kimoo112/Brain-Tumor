import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/logic/app_theme_cubit.dart';

class ThemeToggleListTile extends StatelessWidget {
  const ThemeToggleListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        final isDark = context.read<AppThemeCubit>().isThemeIsDark;
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: ListTile(
            leading: Icon(
              isDark ? CupertinoIcons.moon_circle : CupertinoIcons.sun_max_fill,
              color: isDark ? Colors.amber : Colors.blueAccent,
              size: 36,
            ),
            title: Text(
              isDark ? 'Dark Mode' : 'Light Mode',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Text(
              isDark
                  ? 'Enjoy a comfortable dark experience'
                  : 'Bright and clear light mode',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: Switch(
              value: isDark,
              onChanged: (_) => context.read<AppThemeCubit>().changeTheme(),
              activeColor: Colors.amber,
              inactiveThumbColor: Colors.blueAccent,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
        );
      },
    );
  }
}
