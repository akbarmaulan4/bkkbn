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

    var color =  Utils.colorFromHex(ColorCode.blueSecondary);
    if(widget.detail.rating_color != null && widget.detail.rating_color != ''){
      color =  Utils.colorFromHex(widget.detail.rating_color);
    }

    return Container(
      decoration: ConstantStyle.box_border_field,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: new BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.only(top: 4),
                child: Center(child: TextAvenir(widget.detail.rating, size: 20, color: Colors.white,)),
              ),
              SizedBox(width: 15),
              Expanded(child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    TextAvenir('${widget.detail.value} - ${widget.detail.label}', size: 15, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                    TextAvenirBook(widget.detail.caption, size: 14, color: Colors.grey)
                  ],
                ),
              )),
              AnimatedBuilder(
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
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
              // Icon(Icons.keyboard_arrow_down_rounded, size: 30, color: Colors.grey,)
            ],
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
                    Column(
                      children: loadFile(widget.detail.file),
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
    List<Widget> widgets = [];
    for(FileDetailSubmit submit in data){
      widgets.add(InkWell(
        onTap: ()=>Navigator.pushNamed(context, '/pdf', arguments: {'url':submit.file, 'code':submit.name}),
        child: Container(
          decoration: ConstantStyle.box_fill_grey,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            children: [
              Image.asset(ImageConstant.icPdf, height: 20,),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAvenirBook('Unduh file berikut ini.', size: 13,),
                  TextAvenirBook(submit.name, size: 13),
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
