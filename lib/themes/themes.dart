import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  bool isDarkTheme() {
    return _isDarkTheme;
  }

  void setTheme(b) {
    _isDarkTheme = b;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: CustomColors.primary,
      accentColor: CustomColors.white,
      scaffoldBackgroundColor: CustomColors.white,
      textTheme: TextTheme(),
      iconTheme: IconThemeData(color: Colors.black),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
          backgroundColor:
              MaterialStateProperty.all<Color>(CustomColors.primary),
          overlayColor: MaterialStateProperty.all<Color>(Colors.white24),
          foregroundColor: MaterialStateProperty.all<Color>(CustomColors.white),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(
              200,
              50,
            ),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: CustomColors.primary,
      accentColor: CustomColors.white,
      scaffoldBackgroundColor: CustomColors.black,
      textTheme: ThemeData.dark().textTheme,
      iconTheme: IconThemeData(color: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
          backgroundColor:
              MaterialStateProperty.all<Color>(CustomColors.primary),
          overlayColor: MaterialStateProperty.all<Color>(Colors.white24),
          foregroundColor: MaterialStateProperty.all<Color>(CustomColors.white),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(
              200,
              50,
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration getInputDecoration(hint, [loginErr, s]) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25.0),
        borderSide: new BorderSide(),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25.0),
        borderSide: new BorderSide(color: CustomColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25.0),
        borderSide: new BorderSide(color: CustomColors.primary),
      ),
      hintStyle: TextStyle(
          color: _isDarkTheme ? CustomColors.white : CustomColors.black),
      errorText: loginErr ? s : null,
    );
  }
}

/* Color primary = Color(0xFFBF1E2E);

// Color dpurple = Color(0xFF262626);

Color secondary = Color(0xFFFFFFFF);

Color textcolor = Colors.black;
// Color textcolor = Color(0xFF000000);

Color bordercolor = Color(0xFF343434);
// Color bordercolor = Colors.black45;
 */
