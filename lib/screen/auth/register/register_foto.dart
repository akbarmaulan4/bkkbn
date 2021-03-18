import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/avenir_text.dart';
import 'package:kua/widgets/box_border.dart';

class RegisterFoto extends StatefulWidget {
  AuthBloc bloc;
  RegisterFoto({this.bloc});

  @override
  _RegisterFotoState createState() => _RegisterFotoState();
}

class _RegisterFotoState extends State<RegisterFoto> {
  File _image;
  final picker = ImagePicker();

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        widget.bloc.changeImage(image);
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
        widget.bloc.changeImage(image);
        setState(() {
          _image = image;
        });
      } else {
        print('No image selected.');
      }
    });
  }

  _selectFile() async {
    // FilePick
    // FilePickerResult result = await FilePicker.platform.pickFiles();
    //
    // if(result != null) {
    //   File file = File(result.files.single.path);
    // } else {
    //   // User canceled the picker
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image = widget.bloc.imgFotoKtp;
    widget.bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    widget.bloc.allowFotoKtpUser.listen((event) {
      if(event != null){
        if(event){
          widget.bloc.changeViewRegist(2);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextAvenir(
            'No KTP',
            size: 14,
            color: Utils.colorFromHex(ColorCode.bluePrimary),
          ),
          SizedBox(height: 5),
          BoxBorderDefault(
              child: TextField(
                controller: widget.bloc.edtKtp,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(16),
                  new BlacklistingTextInputFormatter(
                      new RegExp('[\\-|\\,|\\.]')),
                ],
                decoration: ConstantStyle.decorTextField,
              )
          ),
          SizedBox(height: 25),
          DottedBorder(
            color: Colors.black,
            strokeWidth: 1,
            child: Container(
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
                    Image.asset(ImageConstant.noImages, height: size.height * 0.10,),
                    SizedBox(width: 10),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextAvenir(
                          'Foto KTP',
                          size: 12,
                          color: Utils.colorFromHex(ColorCode.bluePrimary),
                        ),
                        SizedBox(height: 8),
                        TextAvenir(
                          'File yang didukung: Word/PDF/jpeg/png',
                          size: 10,
                          color: Colors.grey[400],
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: _image != null ? size.height * 0.33 : size.height * 0.49),
          InkWell(
            onTap: (){
              widget.bloc.validasiFotoKtp();
              // widget.bloc.changeViewRegist(2);
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Utils.colorFromHex(ColorCode.blueSecondary)
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Center(
                child: TextAvenir(
                  'Lanjutkan',
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          )
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
                  new ListTile(
                    leading: new Icon(Icons.file_present),
                    title: new Text('File'),
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
