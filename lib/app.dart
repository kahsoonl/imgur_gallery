import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imgur_gallery/bloc/bloc.dart';
import 'package:imgur_gallery/common/api_provider.dart';
import 'package:imgur_gallery/pages/image_detail.dart';
import 'package:imgur_gallery/pages/pages.dart';
import 'package:imgur_gallery/repository/image_repository.dart';

class ImgurApp extends StatelessWidget {
  final _imageRepository = ImageRepository(apiProvider: APIProvider());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
            builder: (context) => ImageBloc(imageRepository: _imageRepository),
            child: HomePage()),
        '/image_detail': (context) => BlocProvider(
            builder: (context) => ImageBloc(imageRepository: _imageRepository),
            child: ImageDetailPage()),
      },
      theme: _imgurTheme,
    );
  }
}

final _imgurTheme = _buildThemeData();

ThemeData _buildThemeData() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(textTheme: _buildTextTheme(base.textTheme));
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith();
}
