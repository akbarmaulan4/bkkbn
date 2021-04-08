import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/berita/edukasi_bloc.dart';
import 'package:kua/model/edukasi/edukasi_item.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';
import 'package:kua/widgets/pull_refresh_widget.dart';
import 'package:shimmer/shimmer.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bloc.newsCategory(context);
    });


    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });
  }

  is5Inc(){
    var size = MediaQuery.of(context).size;
    if(size.height < 650){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir('Edukasi', color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            child: Container(
              color:Utils.colorFromHex(ColorCode.lightBlueDark),
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: PullRefreshWidget(
        child: StreamBuilder(
          stream: bloc.categoryEdukasi,
          builder: (context, snapshot) {
            List<EdukasiItem> data = [];
            if(snapshot.data != null){
              data = snapshot.data;
            }
            return Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: data.isNotEmpty ? TextAvenir('Kategori Edukasi', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)) :
                    Shimmer.fromColors(child: Container(
                      width: size.width * 0.24,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Utils.colorFromHex('#dfdfdf'),
                      ),
                    ),
                        baseColor: Utils.colorFromHex('#dfdfdf'),
                        highlightColor: Utils.colorFromHex('#eeeeee')),
                  ),
                  Expanded(
                    child: Container(
                      child: CustomScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        slivers: [
                          data.isNotEmpty ? itemCategory(data):itemCategoryShimmer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
        onRefresh: (){
          bloc.newsCategory(context);
        },
      ),
    );
  }

  itemCategory(List<EdukasiItem> data){
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2.7;
    final double itemHeight = size.height / (is5Inc() ? 12:15);
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
                  color: Utils.colorFromHex(item.background),//Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(vertical: is5Inc()?10:10, horizontal: 13),
                child: Row(
                  children: [
                    // Icon(Icons.card_giftcard_sharp, color: Colors.white, size: 30,),
                    Container(
                      width: is5Inc() ? 20:32,
                      height: is5Inc() ? 20:32,
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Center(
                          child: Image.asset(ImageConstant.logoElsimil),
                        ),
                        imageUrl: item != null ? item.image:'',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 0.5,
                      height: size.height / 18,
                      color: Utils.colorFromHex('#26000000'),
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

  itemCategoryShimmer(){
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2.7;
    final double itemHeight = size.height / (is5Inc() ? 12:15);
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
            return shimmerCategory();
          },
          childCount: 5,
        ),
      ),
    );
  }

  shimmerCategory(){
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Utils.colorFromHex('#f2f2f2'),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Utils.colorFromHex('#dfdfdf'),
            highlightColor:Utils.colorFromHex('#eeeeee'),
            child: Container(
              width: is5Inc() ? 40:50,
              height: is5Inc() ? 40:50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Utils.colorFromHex('#f2f2f2'),
              ),
            ),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(child: Container(
                height: size.height * 0.017,
                width: size.width * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Utils.colorFromHex('#dfdfdf'),
                ),
              ),
              baseColor: Utils.colorFromHex('#dfdfdf'),
              highlightColor: Utils.colorFromHex('#eeeeee')),
              SizedBox(height: 5),
              Shimmer.fromColors(child: Container(
                height: size.height * 0.01,
                width: size.width * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Utils.colorFromHex('#dfdfdf'),
                ),
              ),
              baseColor: Utils.colorFromHex('#dfdfdf'),
              highlightColor: Utils.colorFromHex('#eeeeee')),
            ],
          )
        ],
      ),
    );
  }
}
