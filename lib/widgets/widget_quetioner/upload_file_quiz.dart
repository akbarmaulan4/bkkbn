import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_book.dart';
import 'package:rxdart/rxdart.dart';

import '../font/avenir_text.dart';

class UploadFileQuiz extends StatefulWidget {
  int id;
  String question;
  Function changeValue;
  Function changeFileName;
  UploadFileQuiz({
    this.id,
    this.question,
    this.changeValue,
    this.changeFileName
  });
  @override
  _UploadFileQuizState createState() => _UploadFileQuizState();
}

class _UploadFileQuizState extends State<UploadFileQuiz> {

  final picker = ImagePicker();
  final _fileDoc = PublishSubject<File>();
  Stream<File> get fileDoc => _fileDoc.stream;

  bool _isDocument = false;
  bool get isDocument => _isDocument;

  changeDocument(bool val){
    _isDocument = val;
  }

  _imgFromCamera() async {
    changeDocument(false);
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        final bytes = image.readAsBytesSync();
        String img = base64Encode(bytes);
        String fileName = image.path.split('/').last;
        widget.changeFileName(fileName);
        widget.changeValue(img);
        changeDoc(image);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    changeDocument(false);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        final bytes = image.readAsBytesSync();
        String img = base64Encode(bytes);
        String fileName = image.path.split('/').last;
        widget.changeFileName(fileName);
        widget.changeValue(img);
        changeDoc(image);
      } else {
        print('No image selected.');
      }
    });
  }

  _selectFile() async {
    changeDocument(true);
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if(result != null) {
      File file = File(result.files.single.path);
      if(file.existsSync()){
        final bytes = file.readAsBytesSync();
        String img = base64Encode(bytes);
        String fileName = file.path.split('/').last;
        widget.changeFileName(fileName);
        widget.changeValue(img);
        changeDoc(file);
      }
    }
  }

  changeDoc(File val){
    if(val.existsSync()){
      _fileDoc.sink.add(val);
    }else{
      _fileDoc.sink.add(null);
    }
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
                child: StreamBuilder(
                  stream: fileDoc,
                  builder: (context, snapshot) {
                    File data = null;
                    String fileName =  widget.question;
                    if(snapshot.data != null){
                      data = snapshot.data;
                      if(isDocument){
                        fileName = data.path.split('/').last;
                      }
                    }
                    return (!isDocument && data != null) ? Container(
                      child: Image.file(
                        data,
                        width: size.width * 0.88,
                        height: size.height * 0.25,
                        fit: BoxFit.fitHeight,
                      ),
                    ):Row(
                      children: [
                        Container(
                          child: Image.asset(data != null ? ImageConstant.icPdf : ImageConstant.noImages, height: size.height * 0.08),
                          margin: EdgeInsets.all(5),
                        ),
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
                            TextAvenirBook(
                              'File yang didukung: Word/PDF/jpeg/png',
                              size: 13,
                              color: Colors.grey[400],
                            ),
                          ],
                        ))
                      ],
                    );
                  }
                ),
                // child: _image != null ? Container(
                //   child: Image.file(
                //     _image,
                //     width: size.width * 0.88,
                //     height: size.height * 0.25,
                //     fit: BoxFit.fitHeight,
                //   ),
                // ) : StreamBuilder(
                //   stream: fileDoc,
                //   builder: (context, snapshot) {
                //     File exist;
                //     String fileName =  widget.question;
                //     if(snapshot.data != null){
                //       exist = snapshot.data;
                //       fileName = exist.path.split('/').last;
                //     }
                //
                //     return Row(
                //       children: [
                //         Container(
                //           child: Image.asset(exist != null ? ImageConstant.icPdf : ImageConstant.noImages, height: size.height * 0.08),
                //           margin: EdgeInsets.all(5),
                //         ),
                //         SizedBox(width: 10),
                //         Expanded(child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             TextAvenir(
                //               fileName,
                //               size: 14,
                //               color: Utils.colorFromHex(ColorCode.bluePrimary),
                //             ),
                //             SizedBox(height: 8),
                //             TextAvenirBook(
                //               'File yang didukung: Word/PDF/jpeg/png',
                //               size: 13,
                //               color: Colors.grey[400],
                //             ),
                //           ],
                //         ))
                //       ],
                //     );
                //   }
                // ),
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
                  new ListTile(
                    leading: new Icon(Icons.file_present),
                    title: new Text('File'),
                    onTap: () {
                      _selectFile();
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
