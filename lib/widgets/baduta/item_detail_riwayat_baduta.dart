import 'package:flutter/material.dart';
import 'package:kua/model/baduta/detail/model_detail_baduta.dart';
import 'package:kua/model/baduta/detail/model_item_detail_baduta.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:rxdart/rxdart.dart';

class ItemDetailRiwayatBaduta extends StatefulWidget {
  ModelDetailBaduta data;
  ItemDetailRiwayatBaduta(this.data);
  @override
  _ItemDetailRiwayatBadutaState createState() => _ItemDetailRiwayatBadutaState();
}

class _ItemDetailRiwayatBadutaState extends State<ItemDetailRiwayatBaduta> with TickerProviderStateMixin {
  final _open = PublishSubject<bool>();
  Stream<bool> get open => _open.stream;

  bool _statusOpen = true;
  bool get statusOpen => _statusOpen;

  openCard(bool val){
    _statusOpen = !val;
    _open.sink.add(val);
  }

  AnimationController _arrowAnimationController;
  Animation _arrowAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _arrowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation = Tween(begin: 0.0, end: 1.5).animate(_arrowAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: open,
      builder: (context, snapshot) {
        bool status = false;
        if(snapshot.data != null){
          status = snapshot.data;
        }
        return Container(
          decoration: ConstantStyle.boxButton(radius: 0, color: Utils.colorFromHex(ColorCode.lightBlueDark)),
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  _arrowAnimationController.isCompleted
                      ? _arrowAnimationController.reverse()
                      : _arrowAnimationController.forward();
                  openCard(statusOpen);
                },
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: size.height * 0.064,
                      decoration: ConstantStyle.boxButtonOnly(
                          color: Utils.colorFromHex(ColorCode.bluePurplelsimil),
                          topRight: 7,
                          bottomRight: 7
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: Container(
                      child: TextAvenir(widget.data.label),
                    )),
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      child: AnimatedBuilder(
                        animation: _arrowAnimationController,
                        builder: (context, child) => Transform.rotate(
                          angle: _arrowAnimation.value,
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              status ? Column(
                children: [
                  // SizedBox(height: 10),
                  Container(
                    // padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      children: loadItemCart(widget.data.details),
                    ),
                  )
                ],
              ):SizedBox()

            ],
          ),
        );
      }
    );
  }

  loadItemCart(List<ModelItemDetailBaduta> data){
    List<Widget> widgets = [];
    for(int i=0; i<data.length; i++){
      ModelItemDetailBaduta model = data[i];
      widgets.add(Container(
        color: i.isOdd ? Utils.colorFromHex(ColorCode.lightBlueDark):Colors.white,
        // decoration: ConstantStyle.boxButtonBorderOnly(
        //   colorBorder: Colors.grey.shade300,
        //   color: i.isOdd ? Utils.colorFromHex(ColorCode.bgOddTable):Colors.white,
        //   widthBorder: 1
        // ),
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: itemHeader(model),
      ));
    }
    return widgets;
  }

  itemHeader(ModelItemDetailBaduta data){
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 5),
      // decoration: ConstantStyle.boxButtonBorderOnly(
      //     colorBorder: Colors.grey.shade300,
      //     widthBorder: 1
      // ),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Text(data.label),
              )
          ),
          Container(
            width: 1,
            height: 40,
            decoration: ConstantStyle.boxButtonOnly(
                color: Colors.grey.shade200,//Utils.colorFromHex(ColorCode.bluePurplelsimil),
                topRight: 7,
                bottomRight: 7
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                decoration: ConstantStyle.boxButton(radius: 0, color: data.color.contains('#')? Utils.colorFromHex(data.color):Colors.transparent),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(data.value, textAlign: TextAlign.center,),
              )
          )
        ],
      ),
    );
  }
}
