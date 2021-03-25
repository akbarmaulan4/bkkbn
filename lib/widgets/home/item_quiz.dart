import 'package:flutter/material.dart';
import 'package:kua/model/home/item_result.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:rxdart/rxdart.dart';

import '../font/avenir_text.dart';

class ItemQuiz extends StatefulWidget {
  List<ItemResult> result;
  ItemQuiz({this.result});
  @override
  _ItemQuizState createState() => _ItemQuizState();
}

class _ItemQuizState extends State<ItemQuiz> {

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int get currentPage => _currentPage;

  final _selected = PublishSubject<int>();
  Stream<int> get selected => _selected.stream;

  _onPageChanged(int index) {
    _currentPage = index;
    _selected.sink.add(index);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * 0.25,
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: widget.result.length,
              itemBuilder: (context, index) => item(widget.result[index])
          ),
        ),
        StreamBuilder(
          stream: selected,
          builder: (context, snapshot) {
            int index = 0;
            if(snapshot.data != null){
              index = snapshot.data;
            }
            return Positioned(
              // bottom: 0.0,
              child: Container(
                alignment: Alignment.bottomRight,
                height: size.height * 0.25,
                child: Container(
                  height: 25,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: indicator(index),
                  ),
                ),
              ),
            );
          }
        )
      ],
    );
  }

  item(ItemResult data){
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 20),
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          Container(
            decoration: ConstantStyle.box_white,
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: size.height * 0.20,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.13,),
                TextAvenir(data.kuis_title, size: 16,),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Utils.colorFromHex(data.rating_color),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ), //ConstantStyle.box_fill_green,
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.all(10),
            height: size.height * 0.16,
            width: double.maxFinite,
            child: Column(
              children: [
                TextAvenir(data.rating, size: 75, color: Colors.white),
                TextAvenir('${data.member_kuis_nilai}/${data.kuis_max_nilai}', color: Colors.white),
                TextAvenir(data.label,  color: Colors.white)
              ],
            ),
          )
        ],
      ),
    );
  }

  indicator(int selected){
    List<Widget> data = [];
    for(int i=0; i<widget.result.length; i++){
      data.add(Container(
        width: 8.3,
        height: 8.3,
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: new BoxDecoration(
          color: i == selected ? Utils.colorFromHex(ColorCode.bluePrimary) : Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
      ));
    }
    return data;
  }
}
