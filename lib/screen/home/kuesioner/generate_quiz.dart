import 'package:flutter/material.dart';
import 'package:kua/bloc/quiz/quiz_bloc.dart';
import 'package:kua/model/quiz/generate_kuesioner/group_question.dart';
import 'package:kua/model/quiz/generate_kuesioner/pertanyaan.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:kua/widgets/widget_quetioner/autocomplete_quiz.dart';
import 'package:kua/widgets/widget_quetioner/date_quiz.dart';
import 'package:kua/widgets/widget_quetioner/input_quis.dart';
import 'package:kua/widgets/widget_quetioner/radio_quiz.dart';
import 'package:kua/widgets/widget_quetioner/upload_file_quiz.dart';

class GenerateQuiz extends StatefulWidget {
  int id;
  GenerateQuiz(this.id);
  @override
  _GenerateQuizState createState() => _GenerateQuizState();
}

class _GenerateQuizState extends State<GenerateQuiz> {
  List<Widget> dataQuiz = [];
  QuizBloc bloc = QuizBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bloc.listPertanyaanQuiz(context, widget.id);
    });

    bloc.resultSubmit.listen((event) {
      if(event != null){
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/result_quiz',
            (Route<dynamic> route) => false,
            arguments: {'data': event}
            // arguments: {"data", event}
        );
      }
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir('Pencegahan Stunting', color: Utils.colorFromHex(ColorCode.bluePrimary)),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: StreamBuilder(
                    stream: bloc.dataGroupQuestion,
                    builder: (context, snapshot) {
                      List<GroupQuestion> data = [];
                      if(snapshot.data != null){
                        data = snapshot.data;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: loadGroupQuestion(data),
                      );
                    }
                ),
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: ()=> bloc.submitQuiz(context),
                child: Container(
                  decoration: ConstantStyle.boxShadowButon(
                      color: Utils.colorFromHex(ColorCode.blueSecondary),
                      colorShadow: Utils.colorFromHex(ColorCode.lightGreyElsimil),
                      radius: 10,
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 0)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Center(
                    child: TextAvenir(
                      'Simpan',
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              InkWell(
                onTap: ()=>Navigator.of(context).pop(),
                  child: Center(child: TextAvenir('Batal', size: 17, color: Colors.grey,))),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }

  getHeightBox(List<Pertanyaan> data){
    var size = MediaQuery.of(context).size;
    var tinggi = 0.0;
    for(Pertanyaan quest in data){
      if(quest.tipe == 'angka'){
        tinggi = tinggi + (is5Inc() ? size.height * 0.17 : size.height * 0.13);
      }else if(quest.tipe == 'radio'){
        tinggi = tinggi + (is5Inc() ? size.height * 0.14 : size.height * 0.09);
      }
    }
    return tinggi;
  }

  loadGroupQuestion(List<GroupQuestion> data){
    List<Widget> dataWidget = [];
    var sdda = data.where((element) => element.deskripsi == 'widget');
    // String before = '';
    for(int i=0; i<data.length; i++){
      String nomor = '${i}';
      if(sdda.isNotEmpty){
        nomor = '${i}';
      }else if(i < 10){
        nomor = '0${i}';
      }
      // if(i==0){
      //   before = data[i].jenis;
      // }
      dataWidget.add(Container(
        child: Column(
          children: [
            (data[i].deskripsi != null && data[i].deskripsi != '') ? TextAvenir(data[i].deskripsi, size: 16, color: Utils.colorFromHex(ColorCode.bluePrimary)):SizedBox(),
            SizedBox(height: (data[i].deskripsi != null && data[i].deskripsi != '') ? 15:0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                data[i].jenis != 'widget' ? Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 30,
                      decoration: new BoxDecoration(
                        color: Utils.colorFromHex(ColorCode.blueSecondary),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: TextAvenir(nomor, color: Colors.white,)),
                    ),
                    (i+1) != data.length ? Container(
                      height: getHeightBox(data[i].pertanyaan),
                      width: 3,
                      decoration: BoxDecoration(color: Utils.colorFromHex(ColorCode.blueSecondary)),
                    ):SizedBox()
                  ],
                ):SizedBox(),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data[i].jenis != 'widget' ? TextAvenir(data[i].caption, size: 16, color: Utils.colorFromHex(ColorCode.bluePrimary)):SizedBox(),
                      SizedBox(height: data[i].jenis != 'widget' ? 8 : 0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: loadQuestion(data[i].pertanyaan, data[i].jenis),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
            data[i].jenis == 'widget'  ? Divider():SizedBox()
          ],
        ),
      ));
      // before = data[i].jenis;
    }
    return dataWidget;
  }

  loadQuestion(List<Pertanyaan> data, String jenis){
    List<Widget> dataWidget = [];
    for(Pertanyaan quest in data){
      if(quest.tipe == 'angka'){
        InputQuiz input = new InputQuiz();
        input.id = quest.pertanyaan_id;
        input.question = quest.title;
        input.tipe = quest.tipe;
        input.satuan = quest.satuan;
        input.changeValue = (val){
          quest.value = val;
        };
        quest.file_name = '';
        dataWidget.add(input);
      }else if(quest.tipe == 'radio'){
        RadioQuiz radioQuiz = new RadioQuiz();
        radioQuiz.id = quest.pertanyaan_id;
        radioQuiz.questions = quest.element;
        radioQuiz.changeValue = (val){
          quest.value = val;
        };
        quest.file_name = '';
        dataWidget.add(radioQuiz);
      }else if(quest.tipe == 'tanggal'){
        DateQuiz input = new DateQuiz();
        input.id = quest.pertanyaan_id;
        input.question = quest.title;
        input.changeValue = (val){
          quest.value = val;
        };
        quest.file_name = '';
        dataWidget.add(input);
      }else if(quest.tipe == 'autocomplete'){
        AutoCompleteQuiz input = new AutoCompleteQuiz();
        input.id = quest.pertanyaan_id;
        input.question = quest.title;
        input.url = quest.api;
        input.param = quest.params;
        input.changeValue = (val){
          quest.value = val;
        };
        quest.file_name = '';
        dataWidget.add(input);
      }else if(quest.tipe == 'upload'){
        UploadFileQuiz input = new UploadFileQuiz();
        input.id = quest.pertanyaan_id;
        input.question = quest.title;
        input.changeValue = (val){
          quest.value = val;
        };
        input.changeFileName = (val){
          quest.file_name = val;
        };
        dataWidget.add(input);
      }else{
        InputQuiz input = new InputQuiz();
        input.id = quest.pertanyaan_id;
        input.question = quest.title;
        input.tipe = quest.tipe;
        input.satuan = quest.satuan;
        input.changeValue = (val){
          quest.value = val;
        };
        quest.file_name = '';
        dataWidget.add(input);
      }
    }
    return dataWidget;
  }

  sameWidget(int id){
    for(int i=0; i<dataQuiz.length; i++){
      if(dataQuiz[i] is InputQuiz){
        var item = dataQuiz[i] as InputQuiz;
        if(item.id == id){
          return true;
        }
      }else if(dataQuiz[i] is RadioQuiz){
        var item = dataQuiz[i] as RadioQuiz;
        if(item.id == id){
          return true;
        }
      }else if(dataQuiz[i] is DateQuiz){
        var item = dataQuiz[i] as DateQuiz;
        if(item.id == id){
          return true;
        }
      }else if(dataQuiz[i] is AutoCompleteQuiz){
        var item = dataQuiz[i] as AutoCompleteQuiz;
        if(item.id == id){
          return true;
        }
      }else if(dataQuiz[i] is UploadFileQuiz){
        var item = dataQuiz[i] as UploadFileQuiz;
        if(item.id == id){
          return true;
        }
      }
    }
    return false;
  }

}
