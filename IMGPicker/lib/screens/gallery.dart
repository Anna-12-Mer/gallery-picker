import 'dart:convert';
import 'dart:io';

import 'package:IMGPicker/screens/widgets/imageItem.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:IMGPicker/models/imageModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:storage_path/storage_path.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
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
      body: FutureBuilder(
        future: StoragePath.imagesPath, // get All images taken from phone
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<dynamic> list = json.decode(snapshot.data);
            print(list);
            return Container(
              margin: EdgeInsets.all(5),
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  ImageModel imageModel = ImageModel.fromJson(list[index]);
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
                                  ImageItem(images: imageModel.files),
                            ),
                          );
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            FadeInImage(
                              image: FileImage(
                                File(imageModel.files[0]),
                              ),
                              placeholder: MemoryImage(kTransparentImage),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Container(
                              color: Colors.black.withOpacity(0.7),
                              height: 30,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  imageModel.folderName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Regular'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return new StaggeredTile.count(1, index.isEven ? 1.2 : 2);
                },
              ),
            );
          } else {
            return Center(
              child: Text('Loading...'),
            );
          }
        },
      ),
    );
  }
}
