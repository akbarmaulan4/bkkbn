import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/widgets/avenir_text.dart';

class EdukasiView extends StatefulWidget {
  @override
  _EdukasiViewState createState() => _EdukasiViewState();
}

class _EdukasiViewState extends State<EdukasiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir('Edukasi', color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SizedBox(),
      ),
    );
  }
}
