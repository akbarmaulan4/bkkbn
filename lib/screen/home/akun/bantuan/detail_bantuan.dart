import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kua/bloc/akun/akun_bloc.dart';
import 'package:kua/model/akun/bantuan/bantuan_item.dart';
import 'package:kua/model/akun/bantuan/detail_bantuan_model.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class DetailBantuan extends StatefulWidget {
  BantuanItem data;
  DetailBantuan({this.data});

  @override
  _DetailBantuanState createState() => _DetailBantuanState();
}

class _DetailBantuanState extends State<DetailBantuan> {
  AkunBloc bloc = AkunBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bloc.getDetailBantuan(context, widget.data.id.toString());
    });

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir(widget.data.title, color: Utils.colorFromHex(ColorCode.bluePrimary)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
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
        color: Colors.white,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Divider(),
              // Container(
              //     child: Image.asset(ImageConstant.placeHolderFamily)
              // ),
              SizedBox(height: 10),
              StreamBuilder(
                  stream: bloc.detailBantuan,
                  builder: (context, snapshot) {
                    DetailBantuanModel data = new DetailBantuanModel();
                    if(snapshot.data != null){
                      data = snapshot.data;
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextAvenir(data.title != null ? data.title : "", size: 24, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                          SizedBox(height: 10),
                          Html(
                            data: data.content != null ? data.content : '',
                            defaultTextStyle: TextStyle(height: 1.5, fontSize: 14, fontFamily: 'Avenir-Book', color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                          )
                        ],
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
