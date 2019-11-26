import 'package:flutter/material.dart';

class ImgurApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {

      },
      theme: _imgurTheme,
    );
  }
}


final _imgurTheme = _buildThemeData();

ThemeData _buildThemeData() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _buildTextTheme(base.textTheme)
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(

  );
}