import 'package:flutter/material.dart';
import 'package:kua/model/quiz/submit/result/detail_submit.dart';
import 'package:kua/model/quiz/submit/result/result_submit.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/avenir_book.dart';
import 'package:kua/widgets/avenir_text.dart';
import 'package:kua/widgets/widget_quetioner/item_result_quiz.dart';

import '../../../util/Utils.dart';
import '../../../util/color_code.dart';
import '../../../util/constant_style.dart';
import '../../../util/image_constant.dart';
import '../../../widgets/avenir_book.dart';
import '../../../widgets/avenir_text.dart';

class ResultQuiz extends StatefulWidget {
  ResultSubmit data;
  ResultQuiz(this.data);

  @override
  _ResultQuizState createState() => _ResultQuizState();
}

class _ResultQuizState extends State<ResultQuiz>{

  Future<bool> onWillPop() {
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    return Future.value(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: TextAvenir('Hasil Kuesioner', color: Utils.colorFromHex(ColorCode.bluePrimary)),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: ()=>Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))
          ),
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextAvenir('Pencegahan Stunting', size: 24, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                      SizedBox(height: 10),
                      TextAvenirBook('Berdasarkan jawaban kuesioner diberikan pada tanggal ${widget.data.header.created_at} dengan ID ${widget.data.header.kuis_code}, Sebagai berikut', size: 14, color: Colors.grey),
                      SizedBox(height: 30),
                      TextAvenir('Hasil Kuesioner', size: 16, color: Utils.colorFromHex(ColorCode.blueSecondary)),
                      SizedBox(height: 20),
                      Container(
                        decoration: ConstantStyle.box_card(),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Utils.colorFromHex(widget.data.header.rating_color),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  child: Row(
                                    children: [
                                      TextAvenir(widget.data.header.rating, size: 50, color: Colors.white,),
                                      SizedBox(width: 10),
                                      Container(width: 0.5,color: Colors.grey, height: 30,),
                                      SizedBox(width: 10),
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.ideographic,
                                        children: [
                                          TextAvenir('${widget.data.header.member_kuis_nilai}/${widget.data.header.kuis_max_nilai}', size: 15, color: Colors.white,),
                                          TextAvenir('Sehat', size: 13, color: Colors.white,),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                    child: Padding(
                                      padding: EdgeInsets.all(6),
                                        child: Image.asset(ImageConstant.logoPutih, height: 30,)))
                              ],
                            ),
                            SizedBox(height: 10),
                            TextAvenir('Berpotensi Stunting', color: Colors.grey, size: 12,),
                            SizedBox(height: 3),
                            TextAvenirBook('At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias', size: 11,)
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: ()=>Navigator.pushNamed(context, '/pdf', arguments: {'url':widget.data.header.url, 'code':widget.data.header.kuis_code}),
                        child: Container(
                          decoration: ConstantStyle.box_fill_blue_nd,
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            children: [
                              Image.asset(ImageConstant.icPdf, height: 20,),
                              SizedBox(width: 10),
                              TextAvenir('Download Sertificate Siap Nikah', size: 13, color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      TextAvenir('Detail Hasil', size: 16, color: Utils.colorFromHex(ColorCode.blueSecondary)),
                      SizedBox(height: 10),
                      Column(
                        children: loadHasilQuiz(widget.data.detail),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextAvenir('Ulasan Petugas', size: 16, color: Utils.colorFromHex(ColorCode.blueSecondary)),
                      SizedBox(height: 10),
                      Container(
                        decoration: ConstantStyle.box_light_blue_dark,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: TextAvenir('John Cena', size: 16, color: Utils.colorFromHex(ColorCode.colorGreyText))),
                                TextAvenirBook('20 Maret 2021, 09:00', size: 10,),
                              ],
                            ),
                            TextAvenirBook('Petugas BKKBN', size: 14, color: Utils.colorFromHex(ColorCode.colorGreyText)),
                            SizedBox(height: 10),
                            TextAvenirBook('Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis', size: 14, color: Utils.colorFromHex(ColorCode.colorGreyText)),
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      InkWell(
                        onTap: ()=> Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false),
                        child: Container(
                          decoration: ConstantStyle.box_fill_blue_nd,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          child: Center(
                            child: TextAvenir(
                              'Perbaharui',
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadHasilQuiz(List<DetailSubmit> data){
    List<Widget> items = [];
    for(DetailSubmit detail in data){
      items.add(ItemResultQuiz(detail));
    }
    return items;
  }
}
