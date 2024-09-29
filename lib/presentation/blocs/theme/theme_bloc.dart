import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ToggleThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: ThemeData.light())) {
    _loadThemePreference(); // Load the theme preference on initialization
    on<ToggleThemeEvent>((event, emit) async {
      final newTheme = event.isDark ? ThemeData.dark() : ThemeData.light();
      emit(ThemeState(themeData: newTheme));
      await _saveThemePreference(event.isDark);
    });
  }

  Future<void> _saveThemePreference(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false; // Default to false (light mode)
    final themeData = isDarkMode ? ThemeData.dark() : ThemeData.light();
    emit(ThemeState(themeData: themeData));
  }
}

// Define the ThemeEvent and ThemeState
abstract class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {
  final bool isDark;

  ToggleThemeEvent(this.isDark);

  @override
  List<Object?> get props => [isDark];
}

class ThemeState extends Equatable {
  final ThemeData themeData;

  const ThemeState({required this.themeData});

  @override
  List<Object?> get props => [themeData];
}
