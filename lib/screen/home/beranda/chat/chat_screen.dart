import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/chat/bloc_chat.dart';
import 'package:kua/model/chat/chat_item.dart';
import 'package:kua/model/chat/chat_message.dart';
import 'package:kua/model/chat/type_chat_model.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/util/local_data.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class ChatScreen extends StatefulWidget {
  TypeChatModel data;
  ChatScreen({this.data});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  BlocChat bloc = BlocChat();
  final ScrollController controller = ScrollController();
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focus.addListener(_onFocusChange);
    bloc.getAllChat(widget.data.type);
    removeIndicatorChat();

    bloc.finishCat.listen((event) {
      if(event != null){
        if(event){
          Timer(Duration(milliseconds: 500), () => controller.jumpTo(controller.position.maxScrollExtent));
        }
      }
    });
  }

  removeIndicatorChat() async {
    await LocalData.removeChat();
  }

  void _onFocusChange(){
    if(_focus.hasFocus){
      debugPrint("Focus: "+_focus.hasFocus.toString());
      Timer(Duration(milliseconds: 500), () => controller.jumpTo(controller.position.maxScrollExtent));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TextAvenir('ELSIMIL Care (${widget.data.name})', color: Utils.colorFromHex(ColorCode.bluePrimary)),
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
        body: MediaQuery(
          data: scaleFactor,
          child: Column(
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                    stream: bloc.allChat,
                    builder: (context, snapshot) {
                      List<ChatItem> data = [];
                      if(snapshot.data != null){
                        data = snapshot.data;
                      }
                      return data.isNotEmpty ? Container(
                        // child: SingleChildScrollView(
                        //   child: Column(
                        //     children: loadChat(data),
                        //   ),
                        // ),
                        child: ListView.builder(
                            controller: controller,
                            itemCount: data.length,
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (contex, index){
                              // var alignCross = index.isOdd ? MainAxisAlignment.end : MainAxisAlignment.start;
                              ChatItem item = data[index];
                              return Column(
                                children: getChat(item),
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
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.send,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Tulis pesan kamu disini',
                                  hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                  contentPadding: EdgeInsets.only(bottom:16)
                              ),
                              focusNode: _focus,
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    StreamBuilder(
                      stream: bloc.finishCat,
                      builder: (context, snapshot) {
                        var load = false;
                        if(snapshot.data != null){
                          load = snapshot.data;
                        }
                        return InkWell(
                          onTap: (){
                            if(bloc.edtMessage.text != '' && load){
                              bloc.postMessage(bloc.edtMessage.text, widget.data.type);
                            }
                          },
                          child: Container(
                            decoration: ConstantStyle.button_fill_blu,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Center(
                              child: !load ? Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator()
                              ): TextAvenir('Kirim', color: Colors.white,),
                            ),
                          ),
                        );
                      }
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadChat(List<ChatItem> data){
    List<Widget> widgets = [];
    for(ChatItem item in  data){
      //chat petugas
      for(ChatMessage message in item.child){
        if(message.jabatan == ''){
          widgets.add(rightBuble(message));
        }else{
          widgets.add(leftBuble(message));
        }
      }
    }
    return widgets;
  }

  getChat(ChatItem data){
    List<Widget> widgets = [];
    widgets.add(tanggal(data.header));
    for(ChatMessage message in data.child){
      if(message.jabatan == ''){
        widgets.add(rightBuble(message));
      }else{
        widgets.add(leftBuble(message));
      }
    }
    return widgets;
  }

  tanggal(String header){
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: TextAvenirBook(header, size: 11, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
      ),
    );
  }

  rightBuble(ChatMessage msg){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment:  MainAxisAlignment.end,
        children: [
          msg.message.length > 35 ? Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Utils.colorFromHex(ColorCode.bubleRight)
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.only(left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      // TextAvenirBook(msg.message, size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary))
                      Text(msg.message, style: TextStyle(fontSize: 14, color: Utils.colorFromHex(ColorCode.bluePrimary), fontFamily: 'Avenir-Book')),

                    ],
                  ),
                  Align(
                    alignment: (Alignment.topRight),
                    child: TextAvenirBook(msg.jam, size: 9, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                  ),
                ],
              ),
            ),
          ):Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Utils.colorFromHex(ColorCode.bubleRight)
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Wrap(
                  children: [
                    // TextAvenirBook(msg.message, size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary))
                    Text(msg.message, style: TextStyle(fontSize: 14, color: Utils.colorFromHex(ColorCode.bluePrimary), fontFamily: 'Avenir-Book')),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    SizedBox(height: 10),
                    TextAvenirBook(msg.jam, size: 9, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                  ],
                )
                // ,
              ],
            ),
          ),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: msg.pic != '' ? CachedNetworkImage(
                  placeholder: (context, url) => Center(
                    child: Image.asset(ImageConstant.placeHolderElsimil),
                  ),
                  imageUrl: msg.pic, //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2U_L6KJsOv1ZX5v-JScbk8ZO_ZEe5CwOvmA&usqp=CAU',
                  fit: BoxFit.cover,
                ):Image.asset(ImageConstant.icAccount, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }

  leftBuble(ChatMessage msg){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: msg.pic != '' ? 5 : 20),
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: msg.pic != '' ? CachedNetworkImage(
                  placeholder: (context, url) => Center(
                    child: Image.asset(ImageConstant.placeHolderElsimil),
                  ),
                  imageUrl: msg.pic, //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2U_L6KJsOv1ZX5v-JScbk8ZO_ZEe5CwOvmA&usqp=CAU',
                  fit: BoxFit.cover,
                ):Image.asset(ImageConstant.icAccount, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(width: 10),
          msg.message.length > 50 ? Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Utils.colorFromHex(ColorCode.blueSecondary)
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.only(right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAvenir(msg.jabatan, size: 13, color: Utils.colorFromHex(ColorCode.lightGreyElsimil)),
                  SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TextAvenirBook(msg.message, size: 14, color: Colors.white),
                      Wrap(
                        children: [Text(msg.message, style: TextStyle(fontSize: 14, color: Utils.colorFromHex(ColorCode.colorWhite), fontFamily: 'Avenir-Book'))],
                      ),
                      SizedBox(width: 10),
                      Align(
                        alignment: (Alignment.topRight),
                        child: TextAvenirBook(msg.jam, size: 9, color: Colors.white),
                      ),
                    ],
                  ) ,
                ],
              ),
            ),
          ):Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Utils.colorFromHex(ColorCode.blueSecondary)
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.only(right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextAvenir(msg.jabatan, size: 13, color: Utils.colorFromHex(ColorCode.lightGreyElsimil)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Wrap(
                      children: [
                        Text(msg.message, style: TextStyle(fontSize: 14, color: Utils.colorFromHex(ColorCode.colorWhite), fontFamily: 'Avenir-Book')),
                        // TextAvenirBook(msg.message, size: 14, color: Colors.white)
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        SizedBox(height: 10),
                        TextAvenirBook(msg.jam, size: 9, color: Colors.white),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
