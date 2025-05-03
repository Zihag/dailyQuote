import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifier = StateNotifierProvider<ThemeNotifier, ThemeMode>(
    (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<ThemeMode>{
  ThemeNotifier() : super(ThemeMode.system){
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkTheme') ?? false;
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = state == ThemeMode.dark;
    await prefs.setBool('isDarkTheme', !isDark);
    state = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}
