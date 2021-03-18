import 'package:flutter/material.dart';
import 'package:kua/bloc/quiz/quiz_bloc.dart';
import 'package:kua/model/quiz/tab_kuesioner/data_kuesioner.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/avenir_text.dart';

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
      body: Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 22),
                            child: TextAvenir(data.title)
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Utils.colorFromHex(ColorCode.blueSecondary),
                            inactiveTrackColor: Colors.blue[100],
                            trackShape: RoundedRectSliderTrackShape(),
                            trackHeight: 4.0,
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 3.0),
                            thumbColor: Utils.colorFromHex(ColorCode.blueSecondary),
                            overlayColor: Colors.blue.withAlpha(32),
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                            tickMarkShape: RoundSliderTickMarkShape(),
                            activeTickMarkColor: Utils.colorFromHex(ColorCode.blueSecondary),
                            inactiveTickMarkColor: Colors.blue[100],
                            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                            valueIndicatorColor: Colors.redAccent,
                            valueIndicatorTextStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: Slider(
                            value: 30,
                            min: 0,
                            max: 100,
                            divisions: 10,
                            // label: '$_value',
                            onChanged: (value) {
                              // setState(
                              //       () {
                              //     _value = value;
                              //   },
                              // );
                            },
                          ),
                        ),
                        Container(
                          decoration: ConstantStyle.box_fill_grey,
                          margin: EdgeInsets.only(left: 22),
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
