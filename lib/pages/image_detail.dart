import 'package:flutter/material.dart';
import 'package:imgur_gallery/widgets/custom_app_bar.dart';
import 'dart:io';

class ImageDetailPage extends StatefulWidget {
  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  @override
  Widget build(BuildContext context) {
    final _arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Image Details',
      ),
      body: _ImageDetailBody(),
    );
  }
}

class _ImageDetailBody extends StatelessWidget {
  _ImageDetailBody({this.selectedImage}) : assert(selectedImage != null);

  final File selectedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.file(selectedImage),
        TextFormField(

        ),
        TextFormField(

        ),
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text('Upload'),
              onPressed: () {

              },
            ),
            RaisedButton(
              child: Text('Cancel'),
              onPressed: () {

              },
            )
          ],
        )
      ],
    );
  }
}
