import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/quiz/quiz_bloc.dart';
import 'package:kua/model/quiz/tab_kuesioner/data_kuesioner.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/listQuiz/slider_quiz.dart';
import 'package:kua/widgets/pull_refresh_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/font/avenir_text.dart';

class ListQuizView extends StatefulWidget {
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<ListQuizView> {
  QuizBloc bloc = new QuizBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bloc.quizList(context);
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
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir('Daftar Kuesioner', color: Utils.colorFromHex(ColorCode.bluePrimary)),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            child: Container(
              color: Utils.colorFromHex(ColorCode.lightBlueDark),
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: PullRefreshWidget(
        child: MediaQuery(
          data: scaleFactor,
          child: Container(
            color: Colors.white,
            child: StreamBuilder(
              stream: bloc.dataListKuesioner,
              builder: (context, snapshot) {
                List<DataKuesioner> data = [];
                if(snapshot.data != null){
                  data = snapshot.data as List<DataKuesioner>;
                }
                return Column(
                  children: [
                    // data.isNotEmpty || search ? Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(5)),
                    //       border: Border.all(color: Utils.colorFromHex(ColorCode.lightBlueDark))
                    //   ),
                    //   padding: EdgeInsets.only(right: 25),
                    //   margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    //   height: 45,
                    //   child: TextField(
                    //     controller: bloc.edtFind,
                    //     textAlignVertical: TextAlignVertical.center,
                    //     keyboardType: TextInputType.emailAddress,
                    //     decoration: InputDecoration(
                    //         border: InputBorder.none,
                    //         hintText: 'Cari',
                    //         hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                    //         fillColor: Colors.grey,
                    //         prefixIcon: Icon(Icons.search, size: 20, color: Utils.colorFromHex('#CCCCCC'),),
                    //         contentPadding: EdgeInsets.only(bottom: 7)
                    //     ),
                    //     onChanged: (val){
                    //       WidgetsBinding.instance.addPostFrameCallback((_) async {
                    //         bloc.findQuiz(val);
                    //       });
                    //     },
                    //   ),
                    // ): shimmerSearch(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Utils.colorFromHex(ColorCode.lightBlueDark))
                      ),
                      padding: EdgeInsets.only(right: 25),
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      height: 45,
                      child: TextField(
                        controller: bloc.edtFind,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cari',
                            hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                            fillColor: Colors.grey,
                            prefixIcon: Icon(Icons.search, size: 20, color: Utils.colorFromHex('#CCCCCC'),),
                            contentPadding: EdgeInsets.only(bottom: 7)
                        ),
                        onChanged: (val){
                          WidgetsBinding.instance.addPostFrameCallback((_) async {
                            bloc.typingSearch(true);
                            bloc.findQuiz(val);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder(
                          stream: bloc.isSearch,
                          builder: (context, snapshot) {
                            bool search = false;
                            if(snapshot.data != null){
                              search = snapshot.data as bool;
                            }
                            return StreamBuilder(
                              stream: bloc.isTypingSearch,
                              builder: (context, snapshot) {
                                bool typing = false;
                                if(snapshot.data != null){
                                  typing = snapshot.data as bool;
                                }
                                return typing ? Container(
                                  child: CircularProgressIndicator(),
                                ) : Container(
                                  child: search && data.length < 1 ? Container(
                                    child: Column(
                                      children: [
                                        Icon(Icons.search, size: 40, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                                        SizedBox(height: 10),
                                        TextAvenir('Pencarian tidak ditemukan',
                                            size: is5Inc() ? 14:18,
                                            color: Utils.colorFromHex(ColorCode.bluePrimary))
                                      ],
                                    ),
                                  ) : ListView.builder(
                                      itemCount: data.isNotEmpty ? data.length:3,
                                      itemBuilder: (context, index){
                                        return data.isNotEmpty ? itemQuiz(data[index], data.length == index+1):shimmerItemQuiz();
                                      }
                                  ),
                                );
                              }
                            );
                          }
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ),
        onRefresh: (){
          bloc.quizList(context);
        },
      ),
    );
  }

  itemQuiz(DataKuesioner data, bool lastItem){
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/landing_quiz', arguments: {'id': data.id, 'result_id': data.result_id});
      },
      child: Column(
        children: [
          Container(
            decoration: ConstantStyle.boxShadowButtonBorder(
              radius: 5,
              color: Colors.white,
              colorBorder: Utils.colorFromHex(ColorCode.lightBlueDark),
              widthBorder: 0,
              spreadRadius: 1.5,
              colorShadow: Colors.grey[200],
              blurRadius: 4,
              offset: Offset(0, 0)
            ),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Container(
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Center(
                      child: Image.asset(ImageConstant.placeHolderElsimil, width: size.height * 0.11, height: size.height * 0.11),
                    ),
                    errorWidget: (context, url, error) => Image.asset(ImageConstant.placeHolderElsimil, width: size.height * 0.11, height: size.height * 0.11),
                    imageBuilder: (context, imageProvider) => Container(
                      width: size.height * 0.11,
                      height: size.height * 0.11,
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    imageUrl: data != null ? data.thumbnail!:'',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextAvenir(data.title!, size: is5Inc() ? 14:18, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                          SizedBox(height: is5Inc() ? 10:15),
                          TextAvenir('${data.answered}/${data.total_pertanyaan} Pertanyaan telah dijawab', size: is5Inc() ? 11:12.5, color: Colors.grey),
                          SizedBox(height: 2),
                          SliderQuiz(
                            max_questions: data.total_pertanyaan!.toDouble(),
                            result: data.answered!.toDouble(),
                          ),
                          SizedBox(height: is5Inc() ? 8:10),
                          Container(
                            decoration: BoxDecoration(
                              color: data.action == 'start' ? Utils.colorFromHex(ColorCode.blueSecondary) : Utils.colorFromHex(ColorCode.lightBlueDark),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            width: is5Inc() ? size.width * 0.40:size.width * 0.39,
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: data.action == 'start' ? Utils.colorFromHex(ColorCode.lightBlueDark) : (data.background != '' ? Utils.colorFromHex(data.background!) : Utils.colorFromHex(ColorCode.greyElsimil)),
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    height: size.height * 0.025,
                                    width: size.height * 0.025,
                                    child: data.action == 'start' ? Center(child: Icon(Icons.play_arrow_rounded, size: is5Inc()?15:20, color: Utils.colorFromHex(ColorCode.blueSecondary)))
                                        :Center(child: TextAvenir('', color: Colors.white,))//data.rating
                                ),
                                SizedBox(width: 10),
                                TextAvenir(data.action == 'start' ? 'Mulai':'Hasil Kuesioner', size: 13, color: data.action == 'start' ? Utils.colorFromHex(ColorCode.lightBlueDark) : Utils.colorFromHex(ColorCode.bluePrimary))
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
          SizedBox(height: lastItem ? size.height * 0.10:0,)
        ],
      ),
    );
  }

  shimmerSearch(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Shimmer.fromColors(
              baseColor: Utils.colorFromHex('#f2f2f2'),
              highlightColor: Utils.colorFromHex('#eeeeee'),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Utils.colorFromHex('#f2f2f2')
                ),
              )),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  shimmerItemQuiz(){
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: ConstantStyle.boxButton(
              radius: 5,
              color: Utils.colorFromHex('#f2f2f2'),
          ),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: [
              Shimmer.fromColors(
                  baseColor:  Utils.colorFromHex('#dfdfdf'),
                  highlightColor: Utils.colorFromHex('#eeeeee'),
                  child: Container(
                    width: size.height * 0.11,
                    height: size.height * 0.11,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color:  Utils.colorFromHex('#dfdfdf'),
                    ),
                    // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  )),
              SizedBox(width: 10),
              Expanded(child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                      baseColor: Utils.colorFromHex('#dfdfdf'),
                      highlightColor: Utils.colorFromHex('#eeeeee'),
                      child: Container(
                        width: size.width * 0.4,
                        height: size.height * 0.01,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.all(Radius.circular(10)),
                          color:Utils.colorFromHex('#dfdfdf'),
                        ),
                        // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      )),
                  SizedBox(height: is5Inc() ? 10:15),
                  Shimmer.fromColors(
                      baseColor: Utils.colorFromHex('#dfdfdf'),
                      highlightColor: Utils.colorFromHex('#eeeeee'),
                      child: Container(
                        width: size.width * 0.2,
                        height: size.height * 0.005,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Utils.colorFromHex('#dfdfdf'),
                        ),
                        // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      )),
                  SizedBox(height: 3),
                  Shimmer.fromColors(
                      baseColor: Utils.colorFromHex('#dfdfdf'),
                      highlightColor: Utils.colorFromHex('#eeeeee'),
                      child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.005,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Utils.colorFromHex('#dfdfdf'),
                        ),
                        // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      )),
                  SizedBox(height: is5Inc() ? 8:10),
                  Shimmer.fromColors(
                      baseColor: Utils.colorFromHex('#dfdfdf'),
                      highlightColor: Utils.colorFromHex('#eeeeee'),
                      child: Container(
                        width: size.width * 0.3,
                        height: size.height * 0.03,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Utils.colorFromHex('#dfdfdf'),
                        ),
                        // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      )),
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }
}
