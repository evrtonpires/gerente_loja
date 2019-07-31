import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                  color: Colors.pinkAccent,
                  child: Text("Câmera",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () async {
                    File image =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    imageSelected(image);
                  }),
              FlatButton(
                  color: Colors.pinkAccent,
                  child: Text(
                    "Galeria",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () async {
                    File image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    imageSelected(image);
                  }),
            ],
          ),
    );
  }

  void imageSelected(File image) async {
    if (image != null) {
      File croppedImage = await ImageCropper.cropImage(
          sourcePath: image.path, ratioX: 1.0, ratioY: 1.0);
      onImageSelected(croppedImage);
    }
  }
}
