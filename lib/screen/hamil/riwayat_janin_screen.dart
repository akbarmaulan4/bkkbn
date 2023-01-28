import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kua/bloc/hamil/hamil_controller.dart';
import 'package:kua/model/janin/riwayat/model_item_riwayat.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:kua/model/janin/riwayat/model_riwayat_janin.dart';

class RiwayatJaninScreen extends StatefulWidget {

  int? idJanin;
  RiwayatJaninScreen({this.idJanin});

  @override
  _RiwayatJaninScreenState createState() => _RiwayatJaninScreenState();
}

class _RiwayatJaninScreenState extends State<RiwayatJaninScreen> {

  HamilController controller = HamilController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.riwayatJanin(widget.idJanin!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Utils.colorFromHex(ColorCode.colorWhite),
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: ()=>Navigator.pop(context),
          child: Icon(Icons.chevron_left_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary), size: 30,)),
        title: TextAvenir('Riwayat Janin', color: Utils.colorFromHex(ColorCode.bluePrimary),),
      ),
      body: StreamBuilder(
        stream: controller.dataRiwayatJanin,
        builder: (context, snapshot) {
          List<ModelRiwayatJanin> data = [];
          if(snapshot.data != null){
            data = snapshot.data as List<ModelRiwayatJanin>;
          }
          return StreamBuilder(
            stream: controller.dataLegend,
            builder: (context, snapshot) {
              String strLegend = '';
              if(snapshot.data != null){
                strLegend = snapshot.data as String;
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: loadRiwayat(data),
                      ),
                      SizedBox(height: 25),
                      TextAvenir('Keterangan'),
                      SizedBox(height: 10),
                      Container(
                        decoration: ConstantStyle.box_border_grey,
                        padding: EdgeInsets.all(15),
                        child: Html(
                            data: strLegend,
                            // style: {
                            //   // tables will have the below background color
                            //   "table": Style(backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee)),
                            //   // some other granular customizations are also possible
                            //   "tr": Style(border: Border(bottom: BorderSide(color: Colors.grey)),
                            //   ),
                            //   "th": Style(padding: EdgeInsets.all(6), backgroundColor: Colors.grey),
                            //   "td": Style(padding: EdgeInsets.all(6), alignment: Alignment.topLeft),
                            //   // text that renders h1 elements will be red
                            //   "h1": Style(color: Colors.red),
                            // }
    //                               defaultTextStyle: TextStyle(height: 1.5, fontSize: 14, fontFamily: 'Avenir-Book', color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }

  loadRiwayat(List<ModelRiwayatJanin> data){
    List<Widget> widgets = [];
    for(ModelRiwayatJanin model in data){
      widgets.add(cardJanin(model));
    }
    return widgets;
  }

  cardJanin(ModelRiwayatJanin data){
    return data.details!.length > 0 ? Container(
      decoration: ConstantStyle.boxButton(radius: 10, color: Utils.colorFromHex(ColorCode.lightBlueDark)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextAvenir(data.name!),
          SizedBox(height: 10),
          data.details!.length > 0 ? Container(
            decoration: ConstantStyle.boxButton(radius: 10, color: Colors.white),
            padding: EdgeInsets.all(10),
            child: Column(
              children: loadItemDetail(data.details!),
            ),
          ):SizedBox(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: ()=>Navigator.of(context).pushNamed('/detail_riwayat_janin_screen',
                arguments: {'idJanin':widget.idJanin, 'quizId':data.id}),
                child: Container(
                  decoration: ConstantStyle.boxShadowButon(
                    radius: 20, color: Utils.colorFromHex(ColorCode.blueSecondary),
                    colorShadow: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3, blurRadius: 5, offset: Offset(1,3)
                  ),
                  width: 150,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: TextAvenir('Detail', color: Colors.white, size: 14,),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    ):Container(
      width: double.maxFinite,
      decoration: ConstantStyle.boxButton(radius: 10, color: Colors.grey.shade200),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextAvenir(data.name!, color: Utils.colorFromHex(ColorCode.bluePrimary),),
          SizedBox(height: 7),
          Text('Data belum tersedia')
        ],
      ),
    );
  }

  loadItemDetail(List<ModelItemRiwayat> data){
    List<Widget> widgets = [];
    for(ModelItemRiwayat model in data){
      widgets.add(itemCard(model));
    }
    return widgets;
  }

  itemCard(ModelItemRiwayat data){
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Container(
                child: Text(data.label!, style: TextStyle(fontSize: 15, color: Utils.colorFromHex(ColorCode.bluePrimary)),),
              )),
              Container(
                decoration: ConstantStyle.boxButton(radius: 20, color: Utils.colorFromHex(data.color!)),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                width: size.width * 0.27,
                child: Center(
                  // child: Text(getLabel(data.color), style: TextStyle(color: Utils.colorFromHex(data.color)),),
                  child: Text(data.label_color!, style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
