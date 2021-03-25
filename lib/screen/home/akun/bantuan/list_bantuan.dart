import 'package:flutter/material.dart';
import 'package:kua/bloc/akun/akun_bloc.dart';
import 'package:kua/model/akun/bantuan/bantuan_item.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class ListBantuan extends StatefulWidget {
  @override
  _ListBantuanState createState() => _ListBantuanState();
}

class _ListBantuanState extends State<ListBantuan> {
  AkunBloc bloc = AkunBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.bantuan();

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextAvenir('Pusat Bantuan', size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: bloc.dataBantuan,
        builder: (context, snapshot) {
          List<BantuanItem> data = [];
          if(snapshot.data != null){
            data = snapshot.data;
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: loadData(data),
              ),
            ),
          );
        }
      ),
    );
  }

  loadData(List<BantuanItem> param){
    List<Widget> data = [];
    for(BantuanItem item in param){
      data.add(itemList(item));
    }
    return data;
  }
  
  itemList(BantuanItem data){
    return InkWell(
      onTap: ()=>Navigator.pushNamed(context, '/detail_bantuan', arguments: {'data': data}),
      child: Container(
        decoration: ConstantStyle.box_border_grey,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: TextAvenir(data.title, size: 14, color: Utils.colorFromHex(ColorCode.blueSecondary))
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Utils.colorFromHex(ColorCode.blueSecondary))
          ],
        ),
      ),
    );
  }
}
