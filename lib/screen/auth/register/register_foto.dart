import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/debouncher.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterFoto extends StatefulWidget {
  AuthBloc bloc;
  RegisterFoto({this.bloc});

  @override
  _RegisterFotoState createState() => _RegisterFotoState();
}

class _RegisterFotoState extends State<RegisterFoto> {
  File _image;
  final picker = ImagePicker();
  var debouncher = new Debouncer(milliseconds: 500);

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 100, maxWidth: 1024, maxHeight: 768);
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
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 100, maxWidth: 1024, maxHeight: 768);
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
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if(result != null) {
      File file = File(result.files.single.path);
      if(file.existsSync()){
        widget.bloc.changeImage(file);
        widget.bloc.changePdf(file);
      }
    } else {
      // User canceled the picker
    }
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

    widget.bloc.messageKTP.listen((event) {
      if(event != null){
        Utils.dialogInfo(context: context, title: event, ok: ()=>Navigator.pushNamed(context, '/forgot_password'));
        // showTopSnackBar(context, CustomSnackBar.error(message: event));
      }
    });

    // widget.bloc.messageNIK.listen((event) {
    //   if(event != null){
    //     showTopSnackBar(context, CustomSnackBar.error(message: event));
    //     // ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
    //     //     content: new Text(event)
    //     // ));
    //   }
    // });
  }

  is5Inc(){
    var size = MediaQuery.of(context).size;
    if(size.height < 650){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: scaleFactor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                    WhitelistingTextInputFormatter(RegExp("[0-9]")),
                    // new BlacklistingTextInputFormatter(
                    //     new RegExp('[\\-|\\,|\\.]')),
                  ],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukan 16 digit No KTP anda',
                      hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                      contentPadding: EdgeInsets.only(bottom:16)
                  ),
                  onChanged: (val){
                    if(val.length > 15){
                      debouncher.run(() {
                        widget.bloc.checkNIK();
                      });
                    }
                  },//ConstantStyle.decorTextField,
                )
            ),
            SizedBox(height: 25),
            DottedBorder(
              color: Utils.colorFromHex(ColorCode.lightBlueDark),
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
                      fit: BoxFit.cover,
                    ),
                  ) : StreamBuilder(
                    stream: widget.bloc.fileDoc,
                    builder: (context, snapshot) {
                      File exist;
                      String fileName = 'Foto KTP';
                      if(snapshot.data != null){
                        exist = snapshot.data;
                        fileName = exist.path.split('/').last;
                      }
                      return Row(
                        children: [
                          Image.asset(exist != null ? ImageConstant.icPdf : ImageConstant.noImages, height: size.height * 0.10,),
                          SizedBox(width: 10),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextAvenir(
                                fileName,
                                size: 14,
                                color: Utils.colorFromHex(ColorCode.bluePrimary),
                              ),
                              SizedBox(height: 8),
                              TextAvenir(
                                'File yang didukung: jpeg/png',
                                size: 12,
                                color: Colors.grey[400],
                              ),
                            ],
                          ))
                        ],
                      );
                    }
                  ),
                ),
              ),
            ),
            SizedBox(height: _image != null ? is5Inc() ? size.height * 0.23 : size.height * 0.33 : is5Inc() ? size.height * 0.37:size.height * 0.49),
            InkWell(
              onTap: (){
                widget.bloc.validasiFotoKtp();
                // widget.bloc.changeViewRegist(2);
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Utils.colorFromHex(ColorCode.blueSecondary),
                  boxShadow: [
                    BoxShadow(
                      color: Utils.colorFromHex(ColorCode.lightGreyElsimil),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0,0),
                    ),
                  ],
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
                  // new ListTile(
                  //   leading: new Icon(Icons.file_present),
                  //   title: new Text('File'),
                  //   onTap: () {
                  //     _selectFile();
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                ],
              ),
            ),
          );
        }
    );
  }
}
