import 'package:flutter/material.dart';
import 'package:kua/bloc/baduta/baduta_controller.dart';
import 'package:kua/model/baduta/anak/model_item_anak.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class RiwayatBadutaScreen extends StatefulWidget {
  @override
  _RiwayatBadutaScreenState createState() => _RiwayatBadutaScreenState();
}

class _RiwayatBadutaScreenState extends State<RiwayatBadutaScreen> {

  BadutaController controller = BadutaController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.listAnak();
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
        title: TextAvenir('Riwayat', color: Utils.colorFromHex(ColorCode.bluePrimary),),
      ),
      body: StreamBuilder(
        stream: controller.dataAnak,
        builder: (context, snapshot) {
          List<ModelItemAnak> data = [];
          if(snapshot.data != null){
            data = snapshot.data as List<ModelItemAnak>;
          }
          return data.length > 0 ? Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                children: loadAnak(data),
              ),
            ),
          ):noDataView();
        }
      )
      //noDataView(),
    );
  }

  loadAnak(List<ModelItemAnak> data){
    List<Widget> widgets = [];
    for(ModelItemAnak itemAnak in data){
      widgets.add(card(itemAnak.nama!, ()=>Navigator.of(context).pushNamed('/detail_riwayat_baduta_screen', arguments: {'badutaID':itemAnak.id.toString()})));
    }
    return widgets;
  }

  noDataView(){
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.13),
        Image.asset(ImageConstant.placeholder_baby, height: size.height * 0.16,),
        SizedBox(height: 15),
        TextAvenir('Mohon Maaf', color: Utils.colorFromHex(ColorCode.bluePrimary),),
        TextAvenir('Data anak Anda blm tersedia', color: Utils.colorFromHex(ColorCode.bluePrimary),),
        SizedBox(height: 15),
        Text('Petugas akan segera menambahkan setelah Anda mendapatkan pendampingan.', textAlign: TextAlign.center,),
        SizedBox(height: 20),
        // TextAvenir('Pendampingan Hamil')
      ],
    );
  }

  card(String data, Function onClick){
    return InkWell(
      onTap: ()=>onClick(),
      child: Container(
        decoration: ConstantStyle.boxButton(radius: 10, color: Utils.colorFromHex(ColorCode.lightBlueDark)),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Row(
          children: [
            Expanded(child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAvenir(data, color: Utils.colorFromHex(ColorCode.bluePrimary),),
                  // SizedBox(height: 2,),
                  // TextAvenir('HPL : ${data.hpl ?? '-'}', size: 10,),
                ],
              ),
            )),
            Icon(Icons.chevron_right_rounded)
          ],
        ),
      ),
    );
  }
}
