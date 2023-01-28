import 'package:flutter/material.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class NoConnectionScreen extends StatefulWidget {
  Function? onConnect;
  NoConnectionScreen({this.onConnect});
  @override
  _NoConnectionScreenState createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.25),
          Icon(Icons.wifi_off_rounded, size: 100,),
          SizedBox(height: 10),
          TextAvenir('Koneksi anda terputus', size: 14,),
          TextAvenir('Mohon check kembali koneksi anda', size: 14),
          SizedBox(height: size.height * 0.05),
          InkWell(
            onTap: ()=>widget.onConnect!(),
            child: Container(
              decoration: ConstantStyle.box_fill_blue_nd,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: TextAvenir('Coba Lagi', size: 18, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
