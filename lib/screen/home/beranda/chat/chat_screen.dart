import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextAvenir('ESIMIL Care', color: Utils.colorFromHex(ColorCode.bluePrimary)),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: ()=>Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))
          ),
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey.shade300,
                height: 0.5,
              ),
              preferredSize: Size.fromHeight(4.0)),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (contex, index){
                      return Container(
                        width: double.infinity,
                        child: Row(
                          // crossAxisAlignment: index == 2 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.ac_unit),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Utils.colorFromHex(ColorCode.blueSecondary)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: TextAvenirBook('dhsasadsd'),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ),
              ),
              Container(
                color: Colors.grey.shade200,
                height: 65,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white
                        ),
                        child: BoxBorderDefault(
                            child: TextField(
                              // controller: widget.bloc.edtNamaLengkap,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Tulis pesan kamu disini',
                                  contentPadding: EdgeInsets.only(bottom:16)
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      decoration: ConstantStyle.button_fill_blu,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: TextAvenir('Kirim', color: Colors.white,),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        // body: Container(
        //   color: Utils.colorFromHex(ColorCode.lightBlueDark),
        //   child: Expanded(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Expanded(child: Column(
        //           children: [],
        //         )),
        //         Container(
        //           color: Colors.grey.shade200,
        //           height: 65,
        //           padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        //           child: Row(
        //             children: [
        //               Expanded(
        //                 child: Container(
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.all(Radius.circular(5)),
        //                       color: Colors.white
        //                   ),
        //                   child: BoxBorderDefault(
        //                       child: TextField(
        //                         // controller: widget.bloc.edtNamaLengkap,
        //                         textAlignVertical: TextAlignVertical.center,
        //                         decoration: InputDecoration(
        //                             border: InputBorder.none,
        //                             hintText: 'Tulis pesan kamu disini',
        //                             contentPadding: EdgeInsets.only(bottom:16)
        //                         ),
        //                       )
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(width: 15),
        //               Container(
        //                 decoration: ConstantStyle.button_fill_blu,
        //                 padding: EdgeInsets.symmetric(horizontal: 20),
        //                 margin: EdgeInsets.symmetric(vertical: 5),
        //                 child: Center(
        //                   child: TextAvenir('Kirim', color: Colors.white,),
        //                 ),
        //               )
        //             ],
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        // bottomNavigationBar: Container(
        //   color: Colors.grey.shade200,
        //   height: 50,
        //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.all(Radius.circular(5)),
        //             color: Colors.white
        //           ),
        //           child: BoxBorderDefault(
        //               child: TextField(
        //                 // controller: widget.bloc.edtNamaLengkap,
        //                 textAlignVertical: TextAlignVertical.center,
        //                 decoration: InputDecoration(
        //                     border: InputBorder.none,
        //                     hintText: 'Tulis pesan kamu disini',
        //                     contentPadding: EdgeInsets.only(bottom:16)
        //                 ),
        //               )
        //           ),
        //         ),
        //       ),
        //       SizedBox(width: 15),
        //       Container(
        //         decoration: ConstantStyle.button_fill_blu,
        //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        //         child: Center(
        //           child: TextAvenir('Kirim', color: Colors.white,),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
