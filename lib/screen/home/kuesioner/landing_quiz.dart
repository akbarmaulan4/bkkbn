
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kua/bloc/quiz/quiz_bloc.dart';
import 'package:kua/model/quiz/intro/intro_quiz.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class LandingQuiz extends StatefulWidget {
  int id;
  int result_id;
  LandingQuiz({
    this.id,
    this.result_id
  });

  @override
  _LandingQuizState createState() => _LandingQuizState();
}

class _LandingQuizState extends State<LandingQuiz> {
  QuizBloc bloc = new QuizBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bloc.checkVerify(context, widget.id);
    });

    // bloc.messageError.listen((error) {
    //   if(error != null){
    //     Utils.alertError(context, error, () { });
    //   }
    // });
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
        bottom: PreferredSize(
            child: Container(
              color: Utils.colorFromHex(ColorCode.lightBlueDark),
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: bloc.introQuiz,
                builder: (context, snapshot) {
                  IntroQuiz data;
                  if(snapshot.data != null){
                    data = snapshot.data;
                  }
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Center(
                                child: Image.asset(ImageConstant.placeHolderElsimil),
                              ),
                              imageUrl: data != null ? data.image:'',
                              fit: BoxFit.cover,
                            )
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              TextAvenir(data != null ? data.title : "", size: 24, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                              SizedBox(height: 10),
                              Html(
                                data: data != null ? data.deskripsi : '',
                                // defaultTextStyle: TextStyle(height: 1.5, fontSize: 14, fontFamily: 'Avenir-Book', color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                              ),
                              SizedBox(height: size.height * 0.12),
                            ],
                          ),
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
        onTap: (){
          if(bloc.verifkasi){
            if(widget.result_id < 1){
              Navigator.pushNamed(context, '/generate_quiz', arguments: {'id': widget.id, 'title':bloc.dataIntro.title});
            }else{
              Navigator.pushNamed(context, '/detail_riwayat', arguments: {'id': widget.result_id, 'title':bloc.dataIntro.title});
            }
          }else{
            Utils.infoDialog(context, 'Peringatan', 'Silahkan aktivasi akun kamu melalui email yang telah kami kirim', () { });
          }
        },
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 40,
          decoration: ConstantStyle.boxShadowButon(
            radius: 25,
            color: Utils.colorFromHex(ColorCode.blueSecondary),
            colorShadow: Utils.colorFromHex(ColorCode.lightGreyElsimil),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0,0)
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.20, vertical: 20),
          child: Center(child: TextAvenir(widget.result_id == 0 ? 'Mulai Kuesioner':'Lihat Hasil Kuesioner', color: Colors.white,)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
