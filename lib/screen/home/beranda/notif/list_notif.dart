import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/widgets/avenir_book.dart';
import 'package:kua/widgets/avenir_text.dart';

class ListNotif extends StatefulWidget {
  @override
  _ListNotifState createState() => _ListNotifState();
}

class _ListNotifState extends State<ListNotif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir('Notifkasi', color: Utils.colorFromHex(ColorCode.bluePrimary)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: ()=>Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))
        ),
        bottom: PreferredSize(
            child: Container(
              color: Colors.grey.shade300,
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(4.0)),
        actions: [
          Icon(Icons.delete)
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Utils.colorFromHex(ColorCode.lightBlueDark),
                child: ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (context, index){
                    return Container(
                      height: 0.5,
                      color: Colors.grey.shade300,
                      width: double.infinity,
                    );
                  },
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: new BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextAvenirBook('Kuesioner, Hasil kuesioner kamu ditanggapi oleh petugas KB', color: Utils.colorFromHex(ColorCode.bluePrimary), size: 14),
                              SizedBox(height: 15),
                              TextAvenirBook('Kemarin', color: Colors.grey, size: 12,),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
