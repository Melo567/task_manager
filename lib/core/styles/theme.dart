import 'dart:io';

import 'package:flutter/material.dart';


const defaultTextStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

final theme = ThemeData(
  primaryColor: Colors.blue,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.lightBlue,
    onSecondary: Colors.teal,
    error: Colors.redAccent,
    onError: Colors.redAccent,
    surface: Colors.white,
    onSurface: Colors.black87,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    centerTitle: Platform.isIOS,
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(8.0),
    labelStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    hintStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(
        Colors.blue,
      ),
      foregroundColor: WidgetStatePropertyAll(
        Colors.white,
      ),
      fixedSize: WidgetStatePropertyAll(
        Size(280, 48),
      ),
    ),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
  ),
);
