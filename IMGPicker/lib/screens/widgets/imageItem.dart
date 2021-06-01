import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

import 'imageView.dart';

// ignore: must_be_immutable
class ImageItem extends StatefulWidget {
  List<dynamic> images;

  ImageItem({Key key, this.images}) : super(key: key);

  @override
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Images From Gallery',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontFamily: 'Regular'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          itemCount: widget.images.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5.0)),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ImageView(src: (widget.images[index])),
                      ),
                    );
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: FadeInImage(
                    image: FileImage(
                      File(widget.images[index]),
                    ),
                    placeholder: MemoryImage(kTransparentImage),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            );
          },
          staggeredTileBuilder: (index) {
            return new StaggeredTile.count(1, index.isEven ? 1.2 : 2);
          },
        ),
      ),
    );
  }
}
