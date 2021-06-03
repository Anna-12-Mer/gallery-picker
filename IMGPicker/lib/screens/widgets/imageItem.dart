import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

import 'imageView.dart';

class ImageItem extends StatefulWidget {
  final List<dynamic> images;

  const ImageItem({Key key, this.images}) : super(key: key);

  @override
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  List<dynamic> images;
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  int _currentMax = 5;

  @override
  void initState() {
    images = widget.images;
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) _getMoreImages();
    });
  }

  _getMoreImages() {
    print('get more images !');
    for (int i = _currentMax; i < _currentMax + 5; i++) {
      images.add(images[i]);
    }
    _currentMax = _currentMax + 5;
    setState(() {});
  }

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
      body: (images != null)
          ? Container(
              margin: EdgeInsets.all(5),
              child: StaggeredGridView.countBuilder(
                controller: _scrollController,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                itemCount: images.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == images.length) {
                    return Center(
                      child: Text('Loading...'),
                    );
                    // CircularProgressIndicator();
                  }
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
                                  ImageView(src: (images[index])),
                            ),
                          );
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: FadeInImage(
                          image: FileImage(
                            File(images[index]),
                          ),
                          placeholder:
                              MemoryImage(kTransparentImage, scale: 0.1),
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
            )
          : Center(
              child: Text('Loading...'),
            ),
    );
  }
}
