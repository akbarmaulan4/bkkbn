import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kua/bloc/quiz/quiz_bloc.dart';
import 'package:kua/model/quiz/intro/intro_quiz.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';

class LandingQuiz extends StatefulWidget {
  int id;
  LandingQuiz(this.id);

  @override
  _LandingQuizState createState() => _LandingQuizState();
}

class _LandingQuizState extends State<LandingQuiz> {
  QuizBloc bloc = new QuizBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.quizIntro(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir('Kuesioner', color: Utils.colorFromHex(ColorCode.bluePrimary)),
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
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Container(
                  child: Image.asset(ImageConstant.placeHolderFamily)
              ),
              SizedBox(height: 10),
              StreamBuilder(
                stream: bloc.introQuiz,
                builder: (context, snapshot) {
                  IntroQuiz data = new IntroQuiz();
                  if(snapshot.data != null){
                    data = snapshot.data;
                  }
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextAvenir(data.title != null ? data.title : "", size: 24, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                        SizedBox(height: 10),
                        // TextAvenir("Apa itu stunting...", size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                        // SizedBox(height: 5),
                        // TextAvenirBook('drasydvhbsadpioasndosandoandoansoaksl acjbascibaabo cibsaduagdu agdoiadnafioaufagyud aoidhaidgaufbaidha8dgwb90dhwoijqwqtcasvhdbjandadha diakmdadadadaadad'),
                        // SizedBox(height: 10),
                        // TextAvenir("Hal yang harus dipersiapkan sebelum Kuesioner", size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                        // SizedBox(height: 5),
                        // TextAvenirBook('drasydvhbsadpioasndosandoandoansoaksl acjbascibaabo cibsaduagdu agdoiadnafioaufagyud aoidhaidgaufbaidha8dgwb90dhwoijqwqtcasvhdbjandadha diakmdadadadaadad'),
                        Html(
                          data: data.deskripsi != null ? data.deskripsi : '',
                          defaultTextStyle: TextStyle(height: 1.5, fontSize: 14, fontFamily: 'Avenir-Book'),
                        )
                      ],
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: ()=>Navigator.pushNamed(context, '/generate_quiz', arguments: {'id': widget.id}),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Utils.colorFromHex(ColorCode.blueSecondary)
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.20),
          child: Center(child: TextAvenir('Mulai Keusioner', color: Colors.white,)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
