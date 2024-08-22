import 'dart:io';

import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: Colors.blue,
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
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
  ),
);
