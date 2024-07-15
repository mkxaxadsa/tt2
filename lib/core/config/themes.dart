import 'package:flutter/material.dart';

import 'app_colors.dart';

final theme = ThemeData(
  useMaterial3: false,
  primarySwatch: Colors.grey,
  fontFamily: 'Montserrat',
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xffC5C5C5),
    selectionColor: Color(0xffC5C5C5),
    selectionHandleColor: Color(0xffC5C5C5),
  ),
  dialogTheme: const DialogTheme(
    elevation: 2,
    backgroundColor: Colors.black,
  ),
  colorScheme: ColorScheme.fromSwatch(
    accentColor: AppColors.button,
  ),
);
