import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kua/bloc/berita/edukasi_bloc.dart';
import 'package:kua/model/edukasi/edukasi_item.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/widgets/avenir_text.dart';

class EdukasiView extends StatefulWidget {
  @override
  _EdukasiViewState createState() => _EdukasiViewState();
}

class _EdukasiViewState extends State<EdukasiView> {

  EdukasiBloc bloc = new EdukasiBloc();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.newsCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir('Edukasi', color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            child: Container(
              color: Colors.grey.shade300,
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: TextAvenir('Kategori Edukasi', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
              ),
            ),
            StreamBuilder(
              stream: bloc.categoryEdukasi,
              builder: (context, snapshot) {
                List<EdukasiItem> data = [];
                if(snapshot.data != null){
                  data = snapshot.data;
                }
                return itemCategory(data);
              }
            ),
          ],
        ),
      ),
    );
  }

  itemCategory(List<EdukasiItem> data){
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2.7;
    final double itemHeight = size.height / 15;
    return SliverPadding(
      key: scaffoldKey,
      padding: EdgeInsets.all(10.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: (itemWidth / itemHeight)),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                EdukasiItem item = data[index];
            return InkWell(
              onTap: ()=>Navigator.pushNamed(context, '/list_artikel', arguments: {'data':item}),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.card_giftcard_sharp, color: Colors.white, size: 30,),
                    Container(
                      width: 0.5,
                      height: size.height / 18,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Expanded(child: TextAvenir(item.kategori, size: 14, color: Colors.white,))
                  ],
                ),
              ),
            );
          },
          childCount: data.length,
        ),
      ),
    );
  }
}
