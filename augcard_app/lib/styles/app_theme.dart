import 'package:flutter/material.dart';

class AugCardTheme {
  static get toggleButtonsThemeData => ToggleButtonsThemeData(
      fillColor: Colors.red,
      borderColor: Colors.red,
      color: Colors.black,
      selectedColor: Colors.white,
      selectedBorderColor: Colors.red,
      borderWidth: 1.5,
      borderRadius: BorderRadius.circular(10),
      textStyle: const TextStyle(fontWeight: FontWeight.bold));

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          accentColor: Colors.amber,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        toggleButtonsTheme: toggleButtonsThemeData,
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          accentColor: Colors.amber,
          brightness: Brightness.dark,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        toggleButtonsTheme: toggleButtonsThemeData.copyWith(
          color: Colors.white,
          borderColor: Colors.white,
          selectedBorderColor: Colors.white,
        ),
      );
}
