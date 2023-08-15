import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          //0A1931  // white yellow 0xFFFCF8EC
          isDarkTheme
              ? const Color.fromRGBO(33, 19, 19, 1)
              : const Color.fromRGBO(207, 207, 154, 1),
      primaryColor: const Color.fromRGBO(
        186,
        12,
        47,
        1,
      ),
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary: isDarkTheme
                ? const Color(0xFF1a1f3c)
                : const Color.fromRGBO(207, 207, 154, 1),
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          ),
      cardColor: isDarkTheme
          ? const Color.fromRGBO(52, 31, 31, 1)
          : const Color.fromARGB(255, 231, 231, 139),
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
    );
  }
}
