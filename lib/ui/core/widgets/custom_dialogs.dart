import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:image_picker/image_picker.dart';

Future<File> showChooserDialog(BuildContext context, {ImageSource imageSource}) async {
  ImageSource source = imageSource != null ? imageSource : await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            contentPadding: EdgeInsets.all(16.0),
//            title: Text("Choose image from"),
            children: <Widget>[
              Text("Choose image from"),
              EmptySpace(),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context, ImageSource.camera);
                },
                child: Text("Camera"),
                shape: StadiumBorder(),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
                child: Text("Gallery"),
                shape: StadiumBorder(),
              )
            ],
          ));

  if (source == null) {
    return null;
  }

  var image = await ImagePicker.pickImage(source: source);

  return image;
}
