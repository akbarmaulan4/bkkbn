import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kua/model/quiz/submit/result/detail_submit.dart';
import 'package:kua/model/quiz/submit/result/result_submit.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:kua/widgets/widget_quetioner/item_result_quiz.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultQuiz extends StatefulWidget {
  ResultSubmit data;
  bool isEdit;
  String title;
  ResultQuiz(this.data, this.isEdit, this.title);

  @override
  _ResultQuizState createState() => _ResultQuizState();
}

class _ResultQuizState extends State<ResultQuiz>{

  Future<bool> onWillPop() {
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false, arguments: {'loadFirstMenu': widget.isEdit ? 1:0});
    return Future.value(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextAvenir('Riwayat', size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
              onTap: ()=>Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))
          ),
          bottom: PreferredSize(
              child: Container(
                color: Utils.colorFromHex(ColorCode.lightBlueDark),
                height: 0.5,
              ),
              preferredSize: Size.fromHeight(4.0)),
          actions: [
            InkWell(
              onTap: ()=>dialogBarcode(widget.data.header.kuis_code),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.qr_code_outlined, size: 20, color: Colors.grey,),
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextAvenir('Pencegahan Stunting', size: is5Inc() ? 18:24, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                      SizedBox(height: 10),
                      RichText(
                        textScaleFactor: 1.0,
                        text: TextSpan(
                          text: 'Berdasarkan jawaban kuesioner yang diberikan pada tanggal ',
                          style: TextStyle(height: 1.5, fontSize: is5Inc() ? 13:14, fontFamily: 'Avenir-Book', color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                          children: <TextSpan>[
                            TextSpan(text: widget.data.header.tanggal_kuis, style: TextStyle(height: 1.5, fontSize: 14, fontFamily: 'Avenir', color: Utils.colorFromHex(ColorCode.darkGreyElsimil))),
                            TextSpan(text: ' dengan ID '),
                            TextSpan(text: widget.data.header.kuis_code, style: TextStyle(height: 1.5, fontSize: 14, fontFamily: 'Avenir', color: Utils.colorFromHex(ColorCode.darkGreyElsimil))),
                            TextSpan(text: ', Sebagai berikut:'),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      TextAvenir('Hasil Kuesioner', size: is5Inc() ? 14:16, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                      SizedBox(height: 20),
                      Container(
                        decoration: ConstantStyle.boxShadowButon(
                            radius: 8,
                            color: Colors.white,
                            colorShadow: Utils.colorFromHex(ColorCode.lightBlueDark),
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            offset: Offset(0,0)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: ConstantStyle.boxButton(
                                      color: widget.data.header.rating_color != '' ? Utils.colorFromHex(widget.data.header.rating_color):Utils.colorFromHex(ColorCode.blueSecondary),
                                      radius: 10
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  child: Row(
                                    children: [
                                      // TextAvenir(widget.data.header.rating, size: 50, color: Colors.white,),
                                      // SizedBox(width: 10),
                                      // Container(width: 0.5,color: Colors.grey, height: 30,),
                                      // SizedBox(width: 10),
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.ideographic,
                                        children: [
                                          // SizedBox(height: 5),
                                          TextAvenir(widget.data.header.label, size: 16, color: Colors.white,),
                                          // SizedBox(height: 5),
                                          TextAvenir('${widget.data.header.member_kuis_nilai}/${widget.data.header.kuis_max_nilai}', size: 14, color: Colors.white,),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                        child: Image.asset(ImageConstant.logoElsimilPutih, height: is5Inc() ? 18:20,)))
                              ],
                            ),
                            SizedBox(height: 10),
                            TextAvenir(widget.data.header.label, color: Utils.colorFromHex(ColorCode.darkGreyElsimil), size: 14,),
                            SizedBox(height: 3),
                            Text(widget.data.header.deskripsi,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Avenir-book',
                                    color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                              textScaleFactor: 1.0,
                            )
                            // TextAvenirBook(widget.data.header.deskripsi, color: Utils.colorFromHex(ColorCode.darkGreyElsimil), size: 14, lines: 3,)
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: InkWell(
                          onTap: ()=>Navigator.pushNamed(context, '/pdf', arguments: {'url':widget.data.header.url, 'code':widget.data.header.kuis_code}),
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: Utils.colorFromHex(ColorCode.greyElsimil),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              children: [
                                Image.asset(ImageConstant.icPdf3, height: 25,),
                                SizedBox(width: 10),
                                TextAvenir('Unduh Sertifikat', size: 13, color: Utils.colorFromHex(ColorCode.darkGreyElsimil))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:is5Inc() ? 30:50),
                      TextAvenir('Detail Hasil', size: is5Inc() ? 14:16, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                      SizedBox(height: 10),
                      Column(
                        children: loadHasilQuiz(widget.data.detail.isNotEmpty ? widget.data.detail:[]),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 35),
                      InkWell(
                        onTap: ()=> Navigator.pushNamed(context, '/edit_quiz', arguments: {'id': widget.data.header.kuis_id, 'title':widget.title}),//Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false, arguments: {'loadFirstMenu': widget.isEdit ? 1:0}),
                        child: Container(
                          decoration: ConstantStyle.box_fill_blue_nd,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          child: Center(
                            child: TextAvenir(
                              'Perbaharui',
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadHasilQuiz(List<DetailSubmit> data){
    List<Widget> items = [];
    for(DetailSubmit detail in data){
      items.add(ItemResultQuiz(detail));
    }
    return items;
  }

  dialogBarcode(String data){
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
        context: context,
        builder: (contex){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            content:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextAvenir('Kuesioner ID', size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                  SizedBox(height: 3),
                  TextAvenir(data, size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                  SizedBox(height: 10),
                  Container(
                    width: 200.0,
                    height: 200.0,
                    child: QrImage(
                      data: data.toString(),
                      version: QrVersions.auto,
                      size: 200,
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                      onTap: ()=>captureQrcode(data),
                      child: TextAvenir('Simpan QR Code', size: 14, color: Utils.colorFromHex(ColorCode.blueSecondary))
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Future<String> _getPath() {
    return ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
  }

  GlobalKey globalKey = new GlobalKey();
  captureQrcode(String param) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      // Directory extDir = await DownloadsPathProvider.downloadsDirectory;
      // String tempPath = extDir.path;
      String tempPath = await _getPath();
      var filePath = tempPath + '/${param}.png';

      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // final tempDir = await getTemporaryDirectory();
      // var tempDir = await getApplicationDocumentsDirectory();
      // final file = await new File('${tempDir.path}/image.png').create();
      final file = await new File(filePath).create();
      await file.writeAsBytes(pngBytes);

      if(file.existsSync()){
        Navigator.of(context).pop();
        Utils.showConfirmDialog(context, 'Informasi', "QR Code berhasil disimpan, apakah anda ingin melihatnya sekarang?", () {
          OpenFile.open(file.path);
        });
      }

      // final channel = const MethodChannel('channel:me.alfian.share/share');
      // channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }
}
