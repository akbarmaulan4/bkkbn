import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatelessWidget {
  String url;
  String title;
  WebScreen({this.title, this.url});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: TextAvenir(title, color: Utils.colorFromHex(ColorCode.bluePrimary)),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: ()=>Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))
          ),
          bottom: PreferredSize(
              child: Container(
                color: Utils.colorFromHex(ColorCode.lightBlueDark),
                height: 0.5,
              ),
              preferredSize: Size.fromHeight(4.0))
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Expanded(child: Container(
              child: WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (String url){},
              )))
          ],
        ),
      ),
    );
  }
}
