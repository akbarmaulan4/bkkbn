import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kua/bloc/baduta/baduta_controller.dart';
import 'package:kua/model/baduta/detail/model_detail_baduta.dart';
import 'package:kua/model/baduta/detail/model_header_baduta.dart';
import 'package:kua/model/baduta/riwayat/model_riwayat_baduta.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/baduta/item_detail_riwayat_baduta.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class DetailRiwayatBadutaScreen extends StatefulWidget {
  String badutaID;
  DetailRiwayatBadutaScreen(this.badutaID);
  @override
  _DetailRiwayatBadutaScreenState createState() => _DetailRiwayatBadutaScreenState();
}

class _DetailRiwayatBadutaScreenState extends State<DetailRiwayatBadutaScreen> {

  BadutaController controller = BadutaController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.resultQuizBaduta(widget.badutaID);
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
        title: TextAvenir('Detail Riwayat', color: Utils.colorFromHex(ColorCode.bluePrimary),),
      ),
      body: StreamBuilder(
        stream: controller.detailRiwayat,
        builder: (context, snapshot) {
          ModelRiwayatBaduta data = ModelRiwayatBaduta();
          if(snapshot.data != null){
            data = snapshot.data as ModelRiwayatBaduta;
          }
          return data.header != null ? Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data.header != null ? cardHeader(data.header!):SizedBox(),
                  SizedBox(height: 20),
                  data.details != null ? Column(
                    children: loadItemRiwayat(data.details!),
                  ):SizedBox(),
                  SizedBox(height: 25),
                  TextAvenir('Keterangan'),
                  SizedBox(height: 10),
                  Container(
                    decoration: ConstantStyle.box_border_grey,
                    padding: EdgeInsets.all(15),
                    // child: Text('fsydgbansiofasihdaihdaidhcanhuahdcwahciahicamiawrecairipriawhtuivagtobgjastioawraohioawheiawhtetewtwedfsabdsgaudgaudgnaudsauidnhusainhduahduisahnduinashdihasudhasnhdashdhasidhashdasidasasdsad'),
                    child: Html(
                        data: data.data_legends != null ? data.data_legends : '',
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
          ):Center(
            child: TextAvenir('Data Tidak ditemukan'),
          );
        }
      ),
    );
  }

  loadItemRiwayat(List<ModelDetailBaduta> data){
    List<Widget> widgets = [];
    for(ModelDetailBaduta model in data){
      widgets.add(ItemDetailRiwayatBaduta(model));
    }
    return widgets;
  }

  cardHeader(ModelHeaderBaduta data){
    return data.nama_baduta != null ?  Container(
      decoration: ConstantStyle.boxButton(radius: 10, color: Utils.colorFromHex(ColorCode.lightBlueDark)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextAvenir(data.nama_baduta!),
          SizedBox(height: 10),
          Container(
            decoration: ConstantStyle.boxButton(radius: 0, color: Colors.white),
            // padding: EdgeInsets.all(10),
            child: Column(
              children: [
                itemHeader('Tanggal Lahir', data.tanggal_lahir!),
                itemHeader('Jenis Kelamin', data.gender == '1' ? "Laki-laki":'Perempuan'),
                itemHeader('Nama Ibu', data.nama_ibu_baduta!),
                itemHeader('Anak Ke', data.anak_ke!),
                itemHeader('Tgl Kunjungan Petugas', data.tanggal_kunjungan_petugas!)
                // itemCard('Lorem Ipsum Dolor Sit Amet Dolor Sit Amet')
              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    ):SizedBox();
  }
  
  itemHeader(String data, String value){
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Text(data),
                  )
              ),
              // i.isOdd ? SizedBox():Container(
              //   width: 1,
              //   height: 40,
              //   decoration: ConstantStyle.boxButtonOnly(
              //       color: Utils.colorFromHex(ColorCode.bluePurplelsimil),
              //       topRight: 7,
              //       bottomRight: 7
              //   ),
              // ),
              Container(
                width: 1,
                height: 40,
                decoration: ConstantStyle.boxButtonOnly(
                    color: Colors.grey.shade200,//Utils.colorFromHex(ColorCode.bluePurplelsimil),
                    topRight: 7,
                    bottomRight: 7
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    // decoration: ConstantStyle.boxButtonBorderOnly(
                    //   color: Colors.white,
                    //   colorBorder: Colors.grey,
                    //   widthBorder: 1
                    // ),

                    alignment: Alignment.center,
                    child: Center(child: Text(value, textAlign: TextAlign.center,)),
                  )
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
