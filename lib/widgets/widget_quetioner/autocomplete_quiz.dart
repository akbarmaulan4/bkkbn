import 'package:flutter/material.dart';
import 'package:kua/bloc/quiz/quiz_bloc.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/debouncher.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_book.dart';

import '../font/avenir_text.dart';
import '../box_border.dart';

class AutoCompleteQuiz extends StatefulWidget {
  int id;
  String question;
  String url;
  String param;
  String answerTxt;
  Function changeValue;

  AutoCompleteQuiz({
    this.id,
    this.question,
    this.url,
    this.param,
    this.changeValue
  });

  takeAnswer(){
    return answerTxt;
  }

  @override
  _AutoCompleteQuizState createState() => _AutoCompleteQuizState();
}

class _AutoCompleteQuizState extends State<AutoCompleteQuiz> {
  TextEditingController edt = new TextEditingController();
  var debouncher = new Debouncer(milliseconds: 500);
  QuizBloc bloc = new QuizBloc();

  String answer = '';
  setAnswer(String val){
    widget.answerTxt = val;
    widget.changeValue(val);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          TextAvenir(
            widget.question,
            size: 14,
            color: Colors.grey,
          ),
          SizedBox(height: 5),
          InkWell(
            onTap: (){
              showFinder(widget.question, widget.url, widget.param);
            },
            child: BoxBorderDefault(
                child: TextField(
                  controller: edt,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: ConstantStyle.decorTextField,
                  enabled: false,
                  onChanged: (val){
                    setAnswer(val);
                  },
                )
            ),
          ),
        ],
      ),
    );
  }

  void showFinder(String type, String url, String param) async {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
                return Container(
                  height: size.height * 0.50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey[300])
                        ),
                        padding: EdgeInsets.only(right: 25),
                        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        height: 45,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Cari ${type}...',
                              fillColor: Colors.grey,
                              prefixIcon: Icon(Icons.search, size: 20),
                              contentPadding: EdgeInsets.only(bottom: 7)
                          ),
                          onChanged: (val){
                            if(val.length > 2){
                              debouncher.run(() {
                                bloc.finding(url, param, val);
                              });
                            }else{
                              bloc.showInfoMaxLeght(true);
                            }
                            // finding(type, val);
                          },
                        ),
                      ),
                      StreamBuilder(
                        stream: bloc.infoMaxLenght,
                        builder: (context, snapshot) {
                          bool show = true;
                          if(snapshot.data != null){
                            show = snapshot.data;
                          }
                          return show ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: TextAvenirBook('Ketik minimal 3 karakter..', size: 10, color: Colors.red)
                          ):SizedBox();
                        }
                      ),
                      StreamBuilder(
                          stream: bloc.dataFinding,
                          builder: (context, snapshot) {
                            List<dynamic> data = [];
                            if(snapshot.data != null){
                              data = snapshot.data;
                            }
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: (){
                                        // setFindingValue(type, data[index]);
                                        setAnswer(data[index].nama);
                                        edt.text = data[index].nama;
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(data[index].nama),
                                              SizedBox(height: 5),
                                              Container(height: 0.8, width: double.infinity, color: Colors.grey[200],)
                                            ],
                                          )
                                      ),
                                    );
                                  }
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
