import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/avenir_book.dart';

import '../avenir_text.dart';

class UploadFileQuiz extends StatefulWidget {
  int id;
  String question;
  Function changeValue;
  UploadFileQuiz({
    this.id,
    this.question,
    this.changeValue
  });
  @override
  _UploadFileQuizState createState() => _UploadFileQuizState();
}

class _UploadFileQuizState extends State<UploadFileQuiz> {

  File _image;

  final picker = ImagePicker();

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        final bytes = image.readAsBytesSync();
        String img = base64Encode(bytes);
        widget.changeValue(img);
        setState(() {
          _image = image;
        });
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        final bytes = image.readAsBytesSync();
        String img = base64Encode(bytes);
        widget.changeValue(img);
        setState(() {
          _image = image;
        });
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          DottedBorder(
            color: Colors.black,
            strokeWidth: 1,
            child: Container(
              color: Utils.colorFromHex(ColorCode.lightBlueDark),
              child: InkWell(
                onTap: (){
                  showPicker();
                },
                child: _image != null ? Container(
                  child: Image.file(
                    _image,
                    width: size.width * 0.88,
                    height: size.height * 0.25,
                    fit: BoxFit.fitHeight,
                  ),
                ) : Row(
                  children: [
                    Container(
                      child: Image.asset(ImageConstant.noImages, height: size.height * 0.08),
                      margin: EdgeInsets.all(5),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextAvenir(
                          widget.question,
                          size: 14,
                          color: Utils.colorFromHex(ColorCode.bluePrimary),
                        ),
                        SizedBox(height: 8),
                        TextAvenirBook(
                          'File yang didukung: Word/PDF/jpeg/png',
                          size: 13,
                          color: Colors.grey[400],
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showPicker(){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        // backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
