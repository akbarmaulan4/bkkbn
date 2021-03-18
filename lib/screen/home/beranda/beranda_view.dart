import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/avenir_text.dart';
import 'package:kua/widgets/home/list_item_quiz.dart';

class BerandaVIew extends StatefulWidget {
  @override
  _BerandaVIewState createState() => _BerandaVIewState();
}

class _BerandaVIewState extends State<BerandaVIew> {
  // QuizBloc bloc = new QuizBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bloc.quizList();
    // bloc.quizIntrot();
    // bloc.listPertanyaanQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: home(),
    );
  }

  home(){
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.18,
                width: double.infinity,
                color: Utils.colorFromHex(ColorCode.bluePrimary),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.07),
                          TextAvenir('Daftar Kuesioner', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                          Container(
                            height: 80,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: loadListQuizieoner(),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.06),
                          Container(
                            decoration: ConstantStyle.box_light_blue_dark,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.baseline,
                              // textBaseline: TextBaseline.ideographic,
                              children: [
                                Icon(Icons.info_outline_rounded),
                                SizedBox(width: 15),
                                Expanded(
                                  child: TextAvenir('Silahkan aktifkan akun anda melalui email yang kami kirim', size: 12,),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
        Positioned(
          top: size.height * 0.12,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Container(
            width: size.width * 0.70,
            decoration: ConstantStyle.box_card(),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 23),
            child: Row(
              children: [
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: Image.asset(ImageConstant.logo),
                      ),
                      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2U_L6KJsOv1ZX5v-JScbk8ZO_ZEe5CwOvmA&usqp=CAU',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextAvenir('Hi,', size: 24,),
                            Expanded(
                                child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.notifications_none_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary),),
                                        SizedBox(width: 6),
                                        Icon(Icons.chat_bubble, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                                      ],
                                    )
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                        TextAvenir('Siti Nurhaliza', size: 24,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  loadListQuizieoner(){
    var size = MediaQuery.of(context).size;
    List<Widget> data = [];
    for(int i=0; i<2; i++){
      ListItemQuiz item = new ListItemQuiz();
      item.title = 'Pencegahan\nStunting';
      data.add(item);
    }
    return data;
  }
}
