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
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height:  is5Inc() ? size.height * 0.26:size.height * 0.27,
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: widget.result.length > 0 ? widget.result.length : 1,
              itemBuilder: (context, index) => item(widget.result.length > 0 ? widget.result[index]:null)
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
                height: is5Inc() ? size.height * 0.26:size.height * 0.27,
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
    return InkWell(
      onTap: (){
        if(data.result_id < 1){
          Navigator.pushNamed(context, '/landing_quiz', arguments: {'id': data.kuis_id, 'result_id': data.result_id});
        }else{
          Navigator.pushNamed(context, '/detail_riwayat', arguments: {'id':data.result_id});
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Utils.colorFromHex(ColorCode.lightBlueDark),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: EdgeInsets.only(top: is5Inc() ? 24 : 35),
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: is5Inc() ? size.height * 0.22 : size.height * 0.24,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: (data != null && data.rating_color != '') ? Utils.colorFromHex(data.rating_color):Utils.colorFromHex(ColorCode.darkGreyElsimil),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            // color: Utils.colorFromHex(ColorCode.lightBlueDark),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(1,3), // changes position of shadow
                          ),
                        ]
                    ),
                    padding: EdgeInsets.all(is5Inc() ? 2:5),
                    // margin: EdgeInsets.symmetric(horizontal: 15),
                    height: is5Inc() ? size.height * 0.12 : size.height * 0.13,
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        SizedBox(height: is5Inc() ? size.height * 0.04 : size.height * 0.05),
                        TextAvenir((data != null && data.rating_color != '') ? data.label:'Belum ada hasil',  color: Colors.white, size: is5Inc() ? 12:14, textAlign: TextAlign.center),
                        TextAvenir((data != null && data.rating_color != '') ? '${data.member_kuis_nilai}/${data.kuis_max_nilai}':'-', color: Colors.white, size: is5Inc() ? 11:13),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // SizedBox(height: is5Inc() ? size.height * 0.14 : size.height * 0.148),
                  TextAvenir(data != null ? data.kuis_title : '', size: is5Inc() ? 12:14,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  indicator(int selected){
    List<Widget> data = [];
    var totalDot = widget.result.length;
    if(totalDot < 1){
      totalDot = 1;
    }
    for(int i=0; i<totalDot; i++){
      data.add(Container(
        width: 8.3,
        height: 8.3,
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: new BoxDecoration(
          color: i == selected ? Utils.colorFromHex(ColorCode.bluePrimary) : Colors.grey,
          shape: BoxShape.circle,
        ),
      ));
    }
    return data;
  }
}
