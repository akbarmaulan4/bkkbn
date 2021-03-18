import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/pdf/PdfBloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class Pdfview extends StatefulWidget {
  final url;
  String code;
  Pdfview(this.url, this.code);

  @override
  _PdfviewState createState() => _PdfviewState();
}

class _PdfviewState extends State<Pdfview> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  PDFDocument document;
  String url = ''; //"http://conorlastowka.com/book/CitationNeededBook-Sample.pdf";
  PdfBloc bloc = new PdfBloc();
  Directory rootPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDocument();
    
    bloc.fileFetcher.listen((file) {
      if(file != null){
        Utils.showConfirmDialog(context, 'Informasi', "File berhasil didownload, apakah anda ingin melihat file sekarang?", () {
          OpenFile.open(file.path);
        });
      }
    });
  }

  Widget inbox() {
    return InkWell(
      onTap: ()async{
        bloc.donwloadFile(context, widget.url, '${widget.code}.pdf');
      },
      child: new Container(
        margin: EdgeInsets.only(bottom: 60, right: 15),
        child: FloatingActionButton(
          onPressed: null,
          tooltip: 'Inbox',
          child: Icon(Icons.cloud_download),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor:Colors.white,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 33.0,
          icon: new Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: new Text(
          "Invoice",
          style: TextStyle(fontSize:  17, fontWeight: FontWeight.w600, color: Utils.colorFromHex(ColorCode.colorWhite)),
        ),
        backgroundColor: Utils.colorFromHex(ColorCode.colorPrimary),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()):
        Stack(
          children: <Widget>[
            Container(
              child: PDFViewer(
                document: document,
                zoomSteps: 1,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: inbox(),
            )
          ],
        ),
    );
  }
  loadDocument() async {
    // String urlDownload = '${API.BASE_URL}/invoice/download/${widget.orderCode}';
    // String urlShow = '${API.BASE_URL}/invoice/show/${widget.orderCode}';
    if (Platform.isAndroid) {
      rootPath = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      rootPath = await getApplicationDocumentsDirectory();
    }//getTemporaryDirectory();
    // print('PDF ${urlDownload}');
    document = await PDFDocument.fromURL(widget.url);
    setState(() {
      isLoading = false;
    });
  }
}
