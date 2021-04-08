import 'package:flutter/material.dart';
import 'package:kua/model/quiz/generate_kuesioner/list_answers.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';
import 'package:rxdart/rxdart.dart';

class RadioQuiz extends StatefulWidget {
  int id;
  // String headerId;
  // String jenis;
  // String tipe;
  Function changeValue;
  List<ListAnswer> questions;
  ListAnswer answer;

  RadioQuiz({
    this.id,
    this.questions,
    // this.headerId,
    // this.jenis,
    // this.tipe,
    this.changeValue
  });
  @override
  _RadioQuizState createState() => _RadioQuizState();
}

class _RadioQuizState extends State<RadioQuiz> {

  final _choise = PublishSubject<ListAnswer>();
  Stream<ListAnswer> get choise => _choise.stream;

  setAnswer(ListAnswer val){
    widget.answer = val;
    widget.changeValue(val.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row (
          children: loadRadio(),
        ),
      ),
    );
  }

  loadRadio(){
    List<Widget> dataRadio = [];
    for(ListAnswer str in widget.questions){
      dataRadio.add(StreamBuilder(
        stream: choise,
        builder: (context, snapshot) {
          int selectedId = -1;
          ListAnswer data = str;
          if(snapshot.data != null){
            data = snapshot.data;
            selectedId = data.id;
          }
          return Row(
            children: [
              Radio(
                  value: str.id,
                  groupValue: selectedId,
                  activeColor: Utils.colorFromHex(ColorCode.bluePrimary),
                  onChanged: (val){
                    _choise.sink.add(str);
                    setAnswer(str);
                  }
              ),
              TextAvenir(str.option,  size: 14, color: Colors.grey,)
            ],
          );
        }
      ));
    }
    return dataRadio;
  }
}
