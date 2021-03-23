import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/berita/edukasi_bloc.dart';
import 'package:kua/model/edukasi/artikel_item.dart';
import 'package:kua/model/edukasi/edukasi_item.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_book.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';
import 'package:kua/widgets/edukasi/item_artikel.dart';
import 'package:kua/widgets/pull_refresh_widget.dart';

class ListArtikel extends StatefulWidget {
  EdukasiItem data;
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
    bloc.listArtikel(widget.data.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir(widget.data.kategori, color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: ()=>Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))
        ),
        bottom: PreferredSize(
            child: Container(
              color: Colors.grey.shade300,
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
                  data = snapshot.data;
                }
                return data.isNotEmpty ? ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index){
                      return Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey.shade200,
                        margin: EdgeInsets.symmetric(vertical: 5),
                      );
                    },
                    itemBuilder: (context, index){
                      ArtikelItem item = data[index];
                      return InkWell(
                        onTap: ()=>Navigator.pushNamed(context, '/detail_artikel', arguments: {'data': item}),
                        child: ItemArtikelWidget(
                          item: item,
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
          bloc.listArtikel(widget.data.id.toString());
        },
      ),
    );
  }
}
