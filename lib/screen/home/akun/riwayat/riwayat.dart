import 'package:flutter/material.dart';
import 'package:kua/bloc/akun/akun_bloc.dart';
import 'package:kua/model/riwayat/riwayat_item.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  AkunBloc bloc = AkunBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bloc.riwayatQuiz(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            preferredSize: Size.fromHeight(4.0))
      ),
      body: Container(
        color: Utils.colorFromHex(ColorCode.softGreyElsimil),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: StreamBuilder(
          stream: bloc.dataRiwayat,
          builder: (context, snapshot) {
            List<RiwayatItem> data = [];
            if(snapshot.data != null){
              data = snapshot.data as List<RiwayatItem>;
            }
            return data.isNotEmpty ? ListView.separated(
              itemCount: data.length,
              separatorBuilder: (contex, index){
                return Container(
                  width: double.infinity,
                  height: 0.5,
                  color: Utils.colorFromHex(ColorCode.lightBlueDark),
                  margin: EdgeInsets.symmetric(vertical: 5),
                );
              },
              itemBuilder: (contex, index){
                return itemList(data[index]);
              }
            ):Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAvenir('Belum ada data', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                  SizedBox(height: 5),
                  Wrap(
                    children: [
                      Text('Belum terdapat data kuesioner.Silahkan ikuti kuesioner',
                          style: TextStyle(fontSize: 14, color: Utils.colorFromHex(ColorCode.bluePrimary), fontFamily: 'Avenir-Book'),
                        textScaleFactor: 1.0,)
                    ],
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  itemList(RiwayatItem data){
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ()=>Navigator.pushNamed(context, '/detail_riwayat', arguments: {'id':data.id, 'title':data.kuis_title}),
      child: Container(
        // decoration: ConstantStyle.box_border_grey,
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                  decoration: BoxDecoration(
                    color:  data.rating_color != '' ? Utils.colorFromHex(data.rating_color!):Utils.colorFromHex(ColorCode.greyElsimil),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  height: size.height * 0.025,
                  width: size.height * 0.025,
                  child: Center(child: TextAvenir('', color: Colors.white,))//data.rating
              ),
            ),
            SizedBox(width: 15),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAvenir(data.kuis_title!, size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                    SizedBox(height: 5),
                    TextAvenirBook(data.created_at!, size: 12, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Utils.colorFromHex(ColorCode.bluePrimary)),
            )
          ],
        ),
      ),
    );
  }
}
