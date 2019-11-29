import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imgur_gallery/bloc/bloc.dart';
import 'package:imgur_gallery/resources/dimen.dart';
import 'package:imgur_gallery/widgets/custom_app_bar.dart';
import 'dart:io';
import 'dart:convert';

class ImageDetailPage extends StatefulWidget {
  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  @override
  Widget build(BuildContext context) {
    final _arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: CustomAppBar(
        title: 'Image Preview',
      ),
      body: BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          if (state is UploadPreview) {
            return Padding(
              padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
              child: _ImageDetailBody(selectedImage: _arguments),
            );
          }

          if (state is UploadingImage) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
                    child: Text('Uploading image to Imgur... please wait'),
                  ),
                )
              ],
            );
          }

          if (state is UploadSuccess) {
            return _ImageUploadSuccess();
          }

          if (state is UploadFailed || state is UploadError) {
            return _ImageUploadFailed();
          }

          return Container();
        },
      ),
    );
  }
}

class _ImageDetailBody extends StatefulWidget {
  _ImageDetailBody({this.selectedImage}) : assert(selectedImage != null);

  final File selectedImage;

  @override
  __ImageDetailBodyState createState() => __ImageDetailBodyState();
}

class __ImageDetailBodyState extends State<_ImageDetailBody> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _hintTextStyle = TextStyle(color: Colors.grey);
    final _inputDecoration = InputDecoration(
      labelStyle: _hintTextStyle,
      hasFloatingPlaceholder: true,
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.file(widget.selectedImage),
          ),
          Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
            child: TextFormField(
                controller: _nameController,
                decoration: _inputDecoration.copyWith(labelText: 'Image Name'),
                validator: (inputValue) {
                  if (inputValue.isEmpty) {
                    return 'Please enter an image name';
                  }
                  return null;
                }),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  disabledElevation: 0.0,
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  child: Text(
                    'Upload',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      List<int> imageBytes =
                          widget.selectedImage.readAsBytesSync();
                      String base64Image = base64Encode(imageBytes);
                      BlocProvider.of<UploadBloc>(context).add(UploadImage(
                          image: base64Image, name: _nameController.text));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageUploadSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
            child: Icon(Icons.check_circle_outline, color: Colors.green),
          ),
          Padding(
            padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
            child: Text('Image successfully updated'),
          ),
          Padding(
            padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
            child: RaisedButton(
              child: Text('OK', style: TextStyle(color: Colors.white)),
              color: Theme.of(context).accentColor,
              onPressed: () {
                BlocProvider.of<ImageBloc>(context).add(FetchImage());
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _ImageUploadFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
            child: Icon(Icons.error_outline, color: Colors.red),
          ),
          Padding(
            padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
            child: Text('Image failed to upload, please try again'),
          ),
          Padding(
            padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
            child: RaisedButton(
              child: Text('OK', style: TextStyle(color: Colors.white)),
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
