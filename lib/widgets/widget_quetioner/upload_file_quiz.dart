import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:pdf_compressor/pdf_compressor.dart';
import 'package:rxdart/rxdart.dart';
import 'package:path_provider/path_provider.dart';

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
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 100, maxWidth: 1024, maxHeight: 768);
    setState(() async {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        String fileName = image.path.split('/').last;
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        File file = new File('$tempPath/$fileName');
        var fileCompressed = await FlutterImageCompress.compressAndGetFile(
          image.path, file.path,
          quality: 88,
          // rotate: 180,
        );

        final bytes = fileCompressed.readAsBytesSync();
        String img = base64Encode(bytes);
        widget.changeFileName(fileName);
        widget.changeValue(img);
        changeDoc(image);

        // File fileFixed = await Utils.fixExifRotation(image.path);
        // final bytes = fileFixed.readAsBytesSync();

        // final bytes = image.readAsBytesSync();
        // String img = base64Encode(bytes);
        // String fileName = image.path.split('/').last;
        // widget.changeFileName(fileName);
        // widget.changeValue(img);
        // changeDoc(image);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    changeDocument(false);
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 100, maxWidth: 1024, maxHeight: 768);
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
        String fileName = file.path.split('/').last;
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        File fileCompressed = new File('$tempPath/$fileName');
        await PdfCompressor.compressPdfFile(
            file.path, fileCompressed.path, CompressQuality.LOW);

        var sizeFile = Utils.formatFileSize(fileCompressed.lengthSync().toDouble());
        final bytes = fileCompressed.readAsBytesSync();
        // final bytes = file.readAsBytesSync();
        String img = base64Encode(bytes);
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
    var size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          DottedBorder(
            color: Utils.colorFromHex(ColorCode.lightBlueDark),
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
                          child: Image.asset(data != null ? ImageConstant.icPdf : ImageConstant.noImages, height: is5Inc() ? size.height * 0.11:size.height * 0.08),
                          margin: EdgeInsets.all(5),
                        ),
                        SizedBox(width: 10),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TextAvenir(
                            //   fileName,
                            //   size: is5Inc() ? 13:14,
                            //   color: Utils.colorFromHex(ColorCode.bluePrimary),
                            // ),

                            Text(fileName, style: TextStyle(fontSize: is5Inc() ? 13:14, fontFamily: 'Avenir', color: Utils.colorFromHex(ColorCode.bluePrimary))),
                            SizedBox(height: 8),
                            TextAvenirBook(
                              'File yang didukung: Word/PDF/jpeg/png',
                              size: is5Inc() ? 13:14,
                              color: Utils.colorFromHex(ColorCode.darkGreyElsimil),
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
