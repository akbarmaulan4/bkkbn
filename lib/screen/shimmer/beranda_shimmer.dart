import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:shimmer/shimmer.dart';

class BerandaShimmer extends StatefulWidget {
  @override
  _BerandaShimmerState createState() => _BerandaShimmerState();
}

class _BerandaShimmerState extends State<BerandaShimmer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: is5Inc() ? size.height * 0.45:size.height * 0.42,
                width: double.infinity,
                color: Utils.colorFromHex('#f2f2f2'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    SizedBox(height: size.height * 0.05),
                    titleNotifShimmer(),
                    shimmerInfoData()
                    // infoData()
                  ],
                ),
              ),
              SizedBox(height: is5Inc() ? 15:30),
              shimmerBarcode(),
              SizedBox(height: is5Inc() ? 15:30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Shimmer.fromColors(child: Container(
                  height: size.height * 0.03,
                  width: size.width * 0.19,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Utils.colorFromHex('#dfdfdf'),
                  ),
                ),
                baseColor: Utils.colorFromHex('#dfdfdf'),
                highlightColor: Utils.colorFromHex('#eeeeee')),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: loadArtikelShimmer(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  titleNotifShimmer(){
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Shimmer.fromColors(child: Container(
                height: size.height * 0.03,
                width: size.width * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Utils.colorFromHex('#dfdfdf'),
                ),
              ),
              baseColor: Utils.colorFromHex('#dfdfdf'),
              highlightColor: Utils.colorFromHex('#eeeeee')),

              // Expanded(child: Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Shimmer.fromColors(child: Container(
              //       height: is5Inc() ? 17:20, width: is5Inc() ? 17:20,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(5)),
              //         color: Utils.colorFromHex('#dfdfdf'),
              //       ),
              //     ),
              //     baseColor: Utils.colorFromHex('#dfdfdf'),
              //     highlightColor: Utils.colorFromHex('#eeeeee')),
              //     SizedBox(width: 15),
              //     Shimmer.fromColors(child: Container(
              //       height: is5Inc() ? 17:20, width: is5Inc() ? 17:20,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(5)),
              //         color: Utils.colorFromHex('#dfdfdf'),
              //       ),
              //     ),
              //     baseColor: Utils.colorFromHex('#dfdfdf'),
              //     highlightColor: Utils.colorFromHex('#eeeeee'))
              //   ],
              // ))
            ],
          ),
          SizedBox(height: 5),
          Shimmer.fromColors(child: Container(
            height: size.height * 0.022,
            width: size.width * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Utils.colorFromHex('#dfdfdf'),
            ),
          ),
            baseColor: Utils.colorFromHex('#dfdfdf'),
            highlightColor: Utils.colorFromHex('#eeeeee')),
        ],
      ),
    );
  }

  shimmerInfoData(){
    return Container(
      child: Row(
        children: [
          Expanded(
          flex: 2,
          child: shimmerItemQuiz()),
          SizedBox(width: 10),
          Expanded(
          flex: 2,
          child: shimmerItemProfile()),

        ],
      ),
    );
  }

  shimmerItemQuiz(){
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 20,),
        Shimmer.fromColors(
            baseColor: Utils.colorFromHex('#dfdfdf'),
            highlightColor: Utils.colorFromHex('#eeeeee'),
            child: Container(
              height:  is5Inc() ? size.height * 0.26:size.height * 0.23,
              margin: EdgeInsets.symmetric(horizontal: 15),
              color: Utils.colorFromHex('#dfdfdf'),
            )),
      ],
    );
  }

  shimmerItemProfile(){
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: is5Inc() ? 18:23),
        Shimmer.fromColors(
            baseColor: Utils.colorFromHex('#dfdfdf'),
            highlightColor: Utils.colorFromHex('#eeeeee'),
            child: Container(
              height:  size.height * 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: Utils.colorFromHex('#dfdfdf')
              ),
            )),
        SizedBox(height: 15),
        Shimmer.fromColors(
            baseColor: Utils.colorFromHex('#dfdfdf'),
            highlightColor: Utils.colorFromHex('#eeeeee'),
            child: Container(
              height:  size.height * 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: Utils.colorFromHex('#dfdfdf')
              ),
            )),
      ],
    );
  }

  shimmerArtikel(){
    final size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
        baseColor: Utils.colorFromHex('#dfdfdf'),
        highlightColor: Utils.colorFromHex('#eeeeee'),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Utils.colorFromHex('#dfdfdf'),

          ),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          width: size.width * 0.35,
          height:  size.height * 0.20,
          // decoration: ConstantStyle.box_fill_blu,
          // margin: EdgeInsets.symmetric(horizontal: is5Inc() ? 0:0),
        ));
  }

  shimmerBarcode(){
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Shimmer.fromColors(
              baseColor: Utils.colorFromHex('#dfdfdf'),
              highlightColor: Utils.colorFromHex('#eeeeee'),
              child: Container(
                height:  size.height * 0.06,
                decoration: ConstantStyle.boxButton(
                  radius: 5,
                  color: Utils.colorFromHex('#eeeeee')
                ),
                margin: EdgeInsets.symmetric(horizontal: is5Inc() ? 0:0),
              )),
        ],
      ),
    );
  }

  loadArtikelShimmer(){
    List<Widget> dataWidget = [];
    for(int i=0; i<3; i++){
      dataWidget.add(shimmerArtikel());
    }
    return dataWidget;
  }

  is5Inc(){
    var size = MediaQuery.of(context).size;
    if(size.height < 650){
      return true;
    }else{
      return false;
    }
  }
}
