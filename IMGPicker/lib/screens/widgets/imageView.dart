import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class ImageView extends StatefulWidget {
  String src;

  ImageView({this.src});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  File imgSrc;
  @override
  void initState() {
    print('Hallo!');
    imgSrc = File(this.widget.src);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PhotoView(
          imageProvider: Image.file(imgSrc).image,
        ),
      ),
    );
  }
}
