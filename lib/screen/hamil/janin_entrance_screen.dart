import 'package:flutter/material.dart';
import 'package:kua/bloc/hamil/hamil_controller.dart';
import 'package:kua/model/janin/model_janin.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class JaninEntranceScreen extends StatefulWidget {
  @override
  _JaninEntranceScreenState createState() => _JaninEntranceScreenState();
}

class _JaninEntranceScreenState extends State<JaninEntranceScreen> {
  HamilController controller = HamilController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.listJanin();
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        stream: controller.dataJanin,
        builder: (context, snapshot) {
          List<ModelJanin> dataJanin = [];
          if(snapshot.data != null){
            dataJanin = snapshot.data;
          }
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: dataJanin.length > 0 ? Column(
              children: loadCard(dataJanin),
            ):Column(
              children: [
                Container(
                  decoration: ConstantStyle.boxButton(radius: 10, color: Colors.grey.shade200),
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextAvenir('Mohon Maaf.\nData janin anda blm tersedia', color: Utils.colorFromHex(ColorCode.bluePrimary),),
                      SizedBox(height: 15),
                      Text('Petugas akan segera menambahkan setelah anda mendapatkan pendampingan.')
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  
  loadCard(List<ModelJanin> data){
    List<Widget> widgets = [];
    for(ModelJanin model in data){
      widgets.add(card(model, ()=>Navigator.of(context).pushNamed('/riwayat_janin_screen', arguments: {'idJanin':model.id})));
    }
    return widgets;
  }
  card(ModelJanin data, Function onClick){
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
                  TextAvenir(data.name, color: Utils.colorFromHex(ColorCode.bluePrimary),),
                  SizedBox(height: 2,),
                  TextAvenir('HPL : ${data.hpl ?? '-'}', size: 10,),
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
