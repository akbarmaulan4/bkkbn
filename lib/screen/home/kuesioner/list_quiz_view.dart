import 'package:flutter/material.dart';
import 'package:kua/bloc/quiz/quiz_bloc.dart';
import 'package:kua/model/quiz/tab_kuesioner/data_kuesioner.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';
import 'package:kua/widgets/listQuiz/slider_quiz.dart';
import 'package:kua/widgets/pull_refresh_widget.dart';

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
    bloc.quizList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir('Daftra Kuesioner', color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: PullRefreshWidget(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Divider(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.grey[300])
                ),
                padding: EdgeInsets.only(right: 25),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                height: 45,
                child: TextField(
                  // controller: bloc.edtUsername,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Cari',
                      fillColor: Colors.grey,
                      prefixIcon: Icon(Icons.search, size: 20),
                      contentPadding: EdgeInsets.only(bottom: 7)
                  ),
                  onChanged: (val){
                    // finding(type, val);
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: bloc.dataListKuesioner,
                    builder: (context, snapshot) {
                      List<DataKuesioner> data = [];
                      if(snapshot.data != null){
                        data = snapshot.data;
                      }
                      return Container(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index){
                              return itemQuiz(data[index], data.length == index+1);
                            }
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
        onRefresh: (){
          bloc.quizList();
        },
      ),
    );
  }

  itemQuiz(DataKuesioner data, bool lastItem){
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ()=>Navigator.pushNamed(context, '/landing_quiz', arguments: {'id': data.id}),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Utils.colorFromHex(ColorCode.lightBlueDark)),
                color: Colors.white
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        child: Image.asset(
                            ImageConstant.placeHolderFamily)
                    )
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextAvenir(data.title),
                          SizedBox(height: 15),
                          TextAvenir('5/10 Pertanyaan telah dijawab', size: 9, color: Colors.grey),
                          SizedBox(height: 2),
                          SliderQuiz(
                            max_questions: 10,
                            result: 6,
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: ConstantStyle.box_fill_grey,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Row(
                              children: [
                                Container(
                                    decoration: ConstantStyle.box_fill_red,
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                    child: TextAvenir('E', color: Colors.white,)
                                ),
                                SizedBox(width: 10),
                                TextAvenir('Hasil Kuesioner')
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
}
