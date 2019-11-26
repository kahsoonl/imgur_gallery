import 'package:flutter/material.dart';
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
        title: 'Home',
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
        ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Text('$index'),
            );
        }),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            child: Icon(Icons.file_upload),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
