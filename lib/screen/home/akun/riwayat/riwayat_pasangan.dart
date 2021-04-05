import 'package:flutter/material.dart';
import 'package:kua/bloc/akun/akun_bloc.dart';
import 'package:kua/model/riwayat/pasangan_item.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class RiwayatPasangan extends StatefulWidget {
  String id;
  RiwayatPasangan(this.id);
  @override
  _RiwayatPasanganState createState() => _RiwayatPasanganState();
}

class _RiwayatPasanganState extends State<RiwayatPasangan> {

  AkunBloc bloc = AkunBloc();

  is5Inc(){
    var size = MediaQuery.of(context).size;
    if(size.height < 650){
      return true;
    }else{
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.riwayatPasangan(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextAvenir('Hasil Kuesioner', size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
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
        padding: EdgeInsets.symmetric(vertical: 15),
        child: StreamBuilder(
          stream: bloc.dataPasangan,
          builder: (context, snapshot) {
            List<PasanganItem> data = [];
            if(snapshot.data != null){
              data = snapshot.data;
            }
            return ListView.separated(
                itemBuilder: (context, index){
                  PasanganItem item = data[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            TextAvenir(item.title, size: 16, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                            SizedBox(height: 3),
                            TextAvenirBook(item.created_at, size: 12, color: Utils.colorFromHex(ColorCode.lightGreyElsimil)),
                          ],
                        ),
                      ),
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
                        margin: EdgeInsets.only(top:10, bottom: 15, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: ConstantStyle.boxButton(
                                      color: (item != null && item.background != '' )? Utils.colorFromHex(item.background):Utils.colorFromHex(ColorCode.blueSecondary),
                                      radius: 10
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  child: Row(
                                    children: [
                                      // TextAvenir(item != null ? item.rating:'', size: 50, color: Colors.white,),
                                      // SizedBox(width: 10),
                                      // Container(width: 0.5,color: Colors.grey, height: 30,),
                                      // SizedBox(width: 10),
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.ideographic,
                                        children: [
                                          TextAvenir(item != null ? item.label:'', size: 16, color: Colors.white,),
                                          TextAvenir(item != null ? '${item.point}/${item.max_point}':'', size: 15, color: Colors.white,),
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
                            TextAvenir(item != null ? item.label:'', color: Utils.colorFromHex(ColorCode.darkGreyElsimil), size: 12,),
                            SizedBox(height: 3),
                            TextAvenirBook(item != null ? item.deskripsi:'', color: Utils.colorFromHex(ColorCode.darkGreyElsimil), size: 11,)
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index){
                  return Container(
                    width: double.infinity,
                    height: 0.8,
                    color: Utils.colorFromHex(ColorCode.lightBlueDark),
                  );
                },
                itemCount: data.length);
          }
        ),
      ),
    );
  }
}
