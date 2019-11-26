import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget leading;
  final String title;
  final List<Widget> actions;
  final Key key;
  final Color titleColor;
  final PreferredSizeWidget bottom;
  final Color backgroundColor;
  final AlignmentGeometry alignment;

  CustomAppBar({
    this.leading,
    this.title = '',
    this.actions = const <Widget>[],
    this.key,
    this.titleColor = Colors.white,
    this.bottom,
    this.backgroundColor,
    this.alignment,
  }) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: this.widget.alignment == null ? true : false,
      title: Container(
          alignment: this.widget.alignment,
          child: Text(
            this.widget.title,
            style: Theme.of(context).textTheme.title.copyWith(
                color: this.widget.titleColor,
                fontFamily: 'Tahoma'
            ),
          )
      ),
      backgroundColor: this.widget.backgroundColor,
      bottom: this.widget.bottom,
      leading: this.widget.leading,
      actions: this.widget.actions,
    );
  }
}