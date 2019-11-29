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
      body: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          print(state);
          if (state is ImageUninitialized) {
            return Padding(
              padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
              child: _ImageDetailBody(selectedImage: _arguments),
            );
          }

          if (state is UploadingImage) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ImageUploaded) {
            if (state.isSuccess) {
              return _ImageUploadSuccess();
            } else {}
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
  final _descController = TextEditingController();
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
          Padding(
            padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
            child: TextFormField(
              controller: _descController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: _inputDecoration.copyWith(labelText: 'Description'),
              validator: (inputValue) {
                if (inputValue.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
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
                      List<int> imageBytes = widget.selectedImage.readAsBytesSync();
                      print(imageBytes);
                      String base64Image = base64Encode(imageBytes);
                      BlocProvider.of<ImageBloc>(context).add(UploadImage(
                          image: base64Image,
                          name: _nameController.text,
                          desc: _descController.text));
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
        children: <Widget>[
          Icon(Icons.check_circle_outline, color: Colors.green),
          Padding(
            padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
            child: Text('Image successfully updated'),
          ),
          RaisedButton(
            child: Text('OK'),
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
