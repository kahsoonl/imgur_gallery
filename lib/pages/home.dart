import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgur_gallery/bloc/bloc.dart';
import 'package:imgur_gallery/model/imgur_image_model.dart';
import 'package:imgur_gallery/widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Imgur Gallery',
      ),
      body: _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BlocBuilder<ImageBloc, ImageState>(builder: (context, state) {
          if (state is ImageLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ImageLoaded) {
            final List<ImgurImageModel> imageList = state.imageUrl;

            return ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Image.network(imageList[index].imageLink),
                );
              },
            );
          }

          if (state is ImageError) {
            return Center(
              child: Text('Something went wrong, please try again'),
            );
          }

          return Center(child: Text('Start'));
        }),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            child: Icon(Icons.file_upload),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => UploadOptionDialog());
            },
          ),
        ),
//        Positioned(
//          right: 10,
//          bottom: 20,
//          child: FloatingActionButton(
//            child: Icon(Icons.refresh),
//            onPressed: () {
//              BlocProvider.of<ImageBloc>(context).add(FetchImage());
//            },
//          ),
//        )
      ],
    );
  }
}

class UploadOptionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            title: Text('Camera'),
            leading: Icon(Icons.camera),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
              ImagePicker.pickImage(source: ImageSource.camera).then(
                  (selectedImage) => Navigator.of(context, rootNavigator: true)
                      .pushNamed('/image_detail', arguments: selectedImage));
            },
          ),
          ListTile(
            title: Text('Gallery'),
            leading: Icon(Icons.photo),
            onTap: () {
              Navigator.pop(context);
              ImagePicker.pickImage(source: ImageSource.gallery).then(
                  (selectedImage) => Navigator.pushNamed(
                      context, '/image_detail',
                      arguments: selectedImage));
            },
          ),
        ],
      ),
    );
  }
}
