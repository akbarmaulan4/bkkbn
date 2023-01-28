import 'package:flutter/material.dart';
import 'package:kua/bloc/berita/edukasi_bloc.dart';
import 'package:kua/model/edukasi/artikel_item.dart';
import 'package:kua/model/edukasi/edukasi_item.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/widgets/edukasi/item_artikel.dart';
import 'package:kua/widgets/pull_refresh_widget.dart';

import '../../../widgets/font/avenir_text.dart';

class ListArtikel extends StatefulWidget {
  EdukasiItem? data;
  ListArtikel({this.data});
  @override
  _ListArtikelState createState() => _ListArtikelState();
}

class _ListArtikelState extends State<ListArtikel> {

  EdukasiBloc bloc = new EdukasiBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bloc.listArtikel(context, widget.data!.id.toString());
    });

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir(widget.data!.kategori!, color: Utils.colorFromHex(ColorCode.bluePrimary),),
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
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: PullRefreshWidget(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: StreamBuilder(
              stream: bloc.allArtikel,
              builder: (context, snapshot) {
                List<ArtikelItem> data = [];
                if(snapshot.data != null){
                  data = snapshot.data as List<ArtikelItem>;
                }
                return data.isNotEmpty ? ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index){
                      return Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Utils.colorFromHex(ColorCode.lightBlueDark),
                        margin: EdgeInsets.symmetric(vertical: 5),
                      );
                    },
                    itemBuilder: (context, index){
                      ArtikelItem item = data[index];
                      return InkWell(
                        onTap: ()=>Navigator.pushNamed(context, '/detail_artikel', arguments: {'id': item.id.toString()}),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            ItemArtikelWidget(
                              item: item,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    }
                ):Container(
                  color: Colors.white,
                );
              }
          ),
        ),
        onRefresh: (){
          bloc.listArtikel(context, widget.data!.id.toString());
        },
      ),
    );
  }
}
