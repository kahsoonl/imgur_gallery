import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgur_gallery/bloc/bloc.dart';
import 'package:imgur_gallery/model/imgur_image_model.dart';
import 'package:imgur_gallery/resources/resources.dart';
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
          if(state is ImageUninitialized) {
            BlocProvider.of<ImageBloc>(context).add(FetchImage());
          }

          if (state is ImageLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ImageEmpty) {
            return Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
                    child: Icon(Icons.warning, color: Colors.deepOrange),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
                    child: Text('Album is empty, please upload image to imgur'),
                  ),
                ],
              ),
            );
          }

          if (state is ImageLoaded) {
            final List<ImgurImageModel> imageList = state.imageUrl;

            return ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4)),
                          child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(
                                imageList[index].imageLink,
                                fit: BoxFit.fill,
                              ))),
                      Padding(
                        padding:
                            const EdgeInsets.all(MARGIN_PADDING_SIZE_SMALL),
                        child: Center(
                            child: Text(imageList[index].title == null
                                ? 'N/A'
                                : imageList[index].title)),
                      ),
                    ],
                  ),
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
            heroTag: 'upload',
            child: Icon(Icons.file_upload),
            onPressed: () {
              Future<ImageSource> imageSource = showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      UploadOptionDialog(parentContext: context));
              imageSource.then((imageSource) {
                if (imageSource != null) {
                  ImagePicker.pickImage(source: imageSource)
                      .then((selectedImage) {
                    if (selectedImage != null) {
                      Navigator.pushNamed(context, '/image_detail',
                          arguments: selectedImage);
                    }
                  });
                }
              });
            },
          ),
        ),
        Positioned(
          right: 10,
          bottom: 80,
          child: FloatingActionButton(
            heroTag: 'refresh',
            child: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<ImageBloc>(context).add(FetchImage());
            },
          ),
        )
      ],
    );
  }
}

class UploadOptionDialog extends StatelessWidget {
  UploadOptionDialog({this.parentContext});

  final BuildContext parentContext;

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
              Navigator.pop(context, ImageSource.camera);
            },
          ),
          ListTile(
            title: Text('Gallery'),
            leading: Icon(Icons.photo),
            onTap: () {
              Navigator.pop(context, ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
