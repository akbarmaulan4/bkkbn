import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/hamil/hamil_controller.dart';
import 'package:kua/model/janin/riwayat/model_detail_riwayat_janin.dart';
import 'package:kua/model/janin/riwayat/model_item_riwayat_janin.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:kua/widgets/item_detail_riwayat_widget.dart';

class DetailRiwayatJaninScreen extends StatefulWidget {
  int idJanin;
  int quizHamilId;
  DetailRiwayatJaninScreen({this.idJanin, this.quizHamilId});
  @override
  _DetailRiwayatJaninScreenState createState() => _DetailRiwayatJaninScreenState();
}

class _DetailRiwayatJaninScreenState extends State<DetailRiwayatJaninScreen> {


  HamilController bloc = HamilController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bloc.detailRiwayatJanin(idJanin);
    bloc.getDetailRiwayatJanin(widget.idJanin, widget.quizHamilId);

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
        title: TextAvenir('Detail Riwayat Janin', color: Utils.colorFromHex(ColorCode.bluePrimary),),
      ),
      body: StreamBuilder(
        stream: bloc.dataDetailRiwayatJanin,
        builder: (context, snapshot) {
          List<ModelDetailRiwayatJanin> data = [];
          if(snapshot.data != null){
            data = snapshot.data;
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: loadCard(data),
              ),
            ),
          );
        }
      ),
    );
  }

  loadCard(List<ModelDetailRiwayatJanin> data){
    List<Widget> widgets = [];
    for(ModelDetailRiwayatJanin model in data){
      widgets.add(ItemDetailRiwayatWidget(model));
    }
    return widgets;
  }
}
