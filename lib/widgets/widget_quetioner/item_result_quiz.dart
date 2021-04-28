import 'package:flutter/material.dart';
import 'package:kua/model/quiz/submit/result/detail_submit.dart';
import 'package:kua/model/quiz/submit/result/file_detail_submit.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:rxdart/rxdart.dart';

import '../font/avenir_book.dart';
import '../font/avenir_text.dart';

class ItemResultQuiz extends StatefulWidget {
  DetailSubmit detail;
  ItemResultQuiz(this.detail);

  @override
  _ItemResultQuizState createState() => _ItemResultQuizState();
}

class _ItemResultQuizState extends State<ItemResultQuiz> with TickerProviderStateMixin{

  AnimationController _arrowAnimationController;
  Animation _arrowAnimation;

  blocItem bloc = new blocItem();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _arrowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation = Tween(begin: 0.0, end: 3.1).animate(_arrowAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var color =  Utils.colorFromHex(ColorCode.greyElsimil);
    if(widget.detail.rating_color != null && widget.detail.rating_color != ''){
      color =  Utils.colorFromHex(widget.detail.rating_color);
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Utils.colorFromHex(ColorCode.greyElsimil))
      ),
      // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(top: 10, bottom: bloc.isOpen ? 0 : 10),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: new BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.only(top: size.width < 430 ? 0:4),
                  child: Center(child: TextAvenir('', size: size.width < 430 ? 17:20, color: Colors.white,)),//widget.detail.rating
                ),
                SizedBox(width: 15),
                Expanded(child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      TextAvenir(widget.detail.value == ''? widget.detail.label : '${widget.detail.value} - ${widget.detail.label}', size: size.width < 430 ? 13:15, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                      TextAvenirBook(widget.detail.caption, size: size.width < 430 ? 12:14, color: Utils.colorFromHex(ColorCode.greyElsimil))
                    ],
                  ),
                )),
                widget.detail.file.isNotEmpty ? AnimatedBuilder(
                  animation: _arrowAnimationController,
                  builder: (context, child) => Transform.rotate(
                    angle: _arrowAnimation.value,
                    child: InkWell(
                      onTap: (){
                        _arrowAnimationController.isCompleted
                            ? _arrowAnimationController.reverse()
                            : _arrowAnimationController.forward();
                        bloc.changeOpen(!bloc.isOpen);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                        color: Utils.colorFromHex(ColorCode.greyElsimil),
                      ),
                    ),
                  ),
                ):SizedBox()
                // Icon(Icons.keyboard_arrow_down_rounded, size: 30, color: Colors.grey,)
              ],
            ),
          ),
          StreamBuilder(
            stream: bloc.open,
            builder: (context, snapshot) {
              var show = false;
              if(snapshot.data != null){
                show = snapshot.data;
              }
              return show ? Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: loadFile(widget.detail.file),
                      ),
                    )
                  ],
                ),
              ):SizedBox();
            }
          )
        ],
      ),
    );
  }

  loadFile(List<FileDetailSubmit> data){
    var size = MediaQuery.of(context).size;
    List<Widget> widgets = [];
    for(FileDetailSubmit submit in data){
      widgets.add(InkWell(
        onTap: ()=>Navigator.pushNamed(context, '/pdf', arguments: {'url':submit.file, 'code':submit.name}),
        child: Container(
          decoration: BoxDecoration(
            color: Utils.colorFromHex(ColorCode.lightBlueDark),
            border: Border.all(color: Utils.colorFromHex(ColorCode.greyElsimil)),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.symmetric(vertical: size.width < 430 ? 5: 8, horizontal: size.width < 430 ?15:20),
          margin: EdgeInsets.symmetric(horizontal: size.width < 430 ? 35:50, vertical: 7),
          child: Row(
            children: [
              Image.asset(ImageConstant.icPdf2, height: 30,),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAvenirBook('Unduh file berikut ini.', size: size.width < 430 ? 12:13, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                  TextAvenirBook(submit.name, size: size.width < 430 ?12:13, weight: FontWeight.bold, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                ],
              )
            ],
          ),
        ),
      ));
    }
    return widgets;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _arrowAnimationController.dispose();
  }
}

class blocItem{

  final _open = PublishSubject<bool>();
  Stream<bool> get open => _open.stream;

  bool _isOpen = false;
  bool get isOpen => _isOpen;

  changeOpen(bool val){
    _isOpen = val;
    _open.sink.add(val);
  }
}
