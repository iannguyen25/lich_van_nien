import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lich_van_nien/presentation/blocs/theme/theme_bloc.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDarkMode = state.themeData.brightness == Brightness.dark;

        return Switch(
          value: isDarkMode,
          onChanged: (value) {
            BlocProvider.of<ThemeBloc>(context).add(ToggleThemeEvent(value));
          },
        );
      },
    );
  }
}
