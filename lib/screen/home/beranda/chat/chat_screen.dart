import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/chat/bloc_chat.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  BlocChat bloc = BlocChat();

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
          color: Utils.colorFromHex(ColorCode.lightBlueDark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: bloc.allMessage,
                  builder: (context, snapshot) {
                    List<String> data = [];
                    if(snapshot.data != null){
                      data = snapshot.data;
                    }
                    return data.isNotEmpty ? Container(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (contex, index){
                          var alignCross = index.isOdd ? MainAxisAlignment.end : MainAxisAlignment.start;
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            child: Row(
                              // crossAxisAlignment: index == 2 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              mainAxisAlignment: alignCross, //MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    color: Utils.colorFromHex(ColorCode.softGreyElsimil)
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextAvenirBook(data[index], size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                                      // TextAvenirBook(data[index], size: 11, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 32,
                                  width: 32,
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
                              ],
                            ),
                          );
                        }
                      ),
                    ):SizedBox();
                  }
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
                              controller: bloc.edtMessage,
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
                    InkWell(
                      onTap: ()=>bloc.postMessage(bloc.edtMessage.text),
                      child: Container(
                        decoration: ConstantStyle.button_fill_blu,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Center(
                          child: TextAvenir('Kirim', color: Colors.white,),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
