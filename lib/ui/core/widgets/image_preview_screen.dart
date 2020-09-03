import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewScreen extends StatelessWidget {
  ImagePreviewScreen({this.imageUrl, this.file});
  String imageUrl;
  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: InkWell(
              onTap: () => Navigator.pop(context),
            ),
          ),
          Center(
              child: PhotoView(
            heroAttributes: const PhotoViewHeroAttributes(tag: "image"),
            backgroundDecoration: BoxDecoration(color: Colors.black12),
            imageProvider: file != null
                ? FileImage(file)
                : CachedNetworkImageProvider(imageUrl),
          )),
          Positioned(
              top: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  color: Colors.black12,
                  child: FlatButton.icon(
                      label: Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(
                        EvaIcons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ))
        ],
      ),
    );
  }
}

showImagePreview(BuildContext context, {File file, String imageUrl}) {
  if (imageUrl == null && file == null) return;
  showDialog(
      context: context,
      builder: (context) => ImagePreviewScreen(imageUrl: imageUrl, file: file));
}
