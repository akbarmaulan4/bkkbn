import 'package:flutter/material.dart';
import 'package:kua/bloc/quiz/quiz_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:kua/model/quiz/submit/result/result_submit.dart';
import 'package:kua/model/quiz/submit/result/detail_submit.dart';
import 'package:kua/widgets/widget_quetioner/item_result_quiz.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailRiwayat extends StatefulWidget {
  int id;
  DetailRiwayat({this.id});

  @override
  _DetailRiwayatState createState() => _DetailRiwayatState();
}

class _DetailRiwayatState extends State<DetailRiwayat> {

  QuizBloc bloc = QuizBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bloc.detailQuiz(context, widget.id.toString());
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
        backgroundColor: Colors.white,
        title: TextAvenir('Hasil Kuesioner', size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0,
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
        actions: [
          InkWell(
            onTap: ()=>dialogBarcode(bloc.quizCode),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.qr_code_outlined, size: 20, color: Colors.grey,),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: bloc.resultSubmit,
          builder: (context, snapshot) {
            ResultSubmit data;
            if(snapshot.data != null){
              data = snapshot.data;
            }
            return data != null ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextAvenir('Pencegahan Stunting', size: is5Inc() ? 18:24, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: 'Berdasarkan jawaban kuesioner yang diberikan pada tanggal ',
                            style: TextStyle(height: 1.5, fontSize: is5Inc() ? 13:14, fontFamily: 'Avenir-Book', color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                            children: <TextSpan>[
                              TextSpan(text: data != null ? data.header.tanggal_kuis:'', style: TextStyle(height: 1.5, fontSize: 14, fontFamily: 'Avenir', color: Utils.colorFromHex(ColorCode.darkGreyElsimil))),
                              TextSpan(text: ' dengan ID '),
                              TextSpan(text: data != null ? data.header.kuis_code:'', style: TextStyle(height: 1.5, fontSize: 14, fontFamily: 'Avenir', color: Utils.colorFromHex(ColorCode.darkGreyElsimil))),
                              TextSpan(text: ', Sebagai berikut:'),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        TextAvenir('Hasil Kuesioner', size: is5Inc() ? 14:16, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                        SizedBox(height: 20),
                        Container(
                          decoration: ConstantStyle.boxShadowButon(
                              radius: 8,
                              color: Colors.white,
                              colorShadow: Utils.colorFromHex(ColorCode.lightBlueDark),
                              spreadRadius: 1.5,
                              blurRadius: 4,
                              offset: Offset(0,0)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: ConstantStyle.boxButton(
                                        color: data != null ? Utils.colorFromHex(data.header.rating_color):Utils.colorFromHex(ColorCode.blueSecondary),
                                        radius: 10
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    child: Row(
                                      children: [
                                        // TextAvenir(data != null ? data.header.rating:'', size: 50, color: Colors.white,),
                                        // SizedBox(width: 10),
                                        // Container(width: 0.5,color: Colors.grey, height: 30,),
                                        // SizedBox(width: 5),
                                        Expanded(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.ideographic,
                                          children: [
                                            // SizedBox(height: 5),
                                            TextAvenir(data != null ? data.header.label:'', size: 16, color: Colors.white,),
                                            // SizedBox(height: 2),
                                            TextAvenir(data != null ? '${data.header.member_kuis_nilai}/${data.header.kuis_max_nilai}':'', size: 14, color: Colors.white,),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                          child: Image.asset(ImageConstant.logoElsimilPutih, height: is5Inc() ? 18:20,)))
                                ],
                              ),
                              SizedBox(height: 10),
                              TextAvenir(data != null ? data.header.label:'', color: Utils.colorFromHex(ColorCode.darkGreyElsimil), size: 14,),
                              SizedBox(height: 3),
                              TextAvenirBook(data != null ? data.header.deskripsi:'', color: Utils.colorFromHex(ColorCode.darkGreyElsimil), size: 14,)
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: InkWell(
                            onTap: ()=>Navigator.pushNamed(context, '/pdf', arguments: {'url':data.header.url, 'code':data.header.kuis_code}),
                            child: Container(
                              width: is5Inc() ? 200:170,
                              decoration: BoxDecoration(
                                color: data.header.url != '' ? Utils.colorFromHex(ColorCode.bluePrimary):Utils.colorFromHex(ColorCode.greyElsimil),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: Row(
                                children: [
                                  Image.asset(ImageConstant.icPdf3, height: 25,),
                                  SizedBox(width: 10),
                                  TextAvenir('Unduh Sertifikat', size: 13, color: data.header.url != '' ? Utils.colorFromHex(ColorCode.lightBlueDark):Utils.colorFromHex(ColorCode.darkGreyElsimil))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height:is5Inc() ? 30:50),
                        TextAvenir('Detail Hasil', size: is5Inc() ? 14:16, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                        SizedBox(height: 10),
                        Column(
                          children: loadHasilQuiz(data != null ? data.detail:[]),
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
                        (data != null && data.ulasan != null) ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextAvenir('Ulasan Petugas', size: 16, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  color: Utils.colorFromHex(ColorCode.lightBlueDark),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: TextAvenir((data != null && data.ulasan != null) ? data.ulasan.name :'', size: 16, color: Utils.colorFromHex(ColorCode.darkGreyElsimil))),
                                      TextAvenirBook((data != null && data.ulasan != null) ? data.ulasan.tanggal_ulasan:'', size: 10, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                                    ],
                                  ),
                                  TextAvenirBook((data != null && data.ulasan != null) ? data.ulasan.jabatan:'', size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                                  SizedBox(height: 10),
                                  TextAvenirBook((data != null && data.ulasan != null) ? data.ulasan.komentar:'', size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                                ],
                              ),
                            ),
                          ],
                        ):SizedBox(),
                        SizedBox(height: 35),
                        InkWell(
                          onTap: ()=> Navigator.pushNamed(context, '/edit_quiz', arguments: {'id': data.header.kuis_id}),
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
            ):SizedBox();
          }
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

  dialogBarcode(String data){
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
        context: context,
        builder: (contex){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            content:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200.0,
                    height: 200.0,
                    child: QrImage(
                      data: data,
                      version: QrVersions.auto,
                      size: 200,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
