import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kua/bloc/home/home_bloc.dart';
import 'package:kua/model/home/data_home.dart';
import 'package:kua/model/home/item_edukasi.dart';
import 'package:kua/model/home/item_info.dart';
import 'package:kua/model/home/own.dart';
import 'package:kua/screen/shimmer/beranda_shimmer.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/util/local_data.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:kua/widgets/home/item_info_profile.dart';
import 'package:kua/widgets/home/item_quiz.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:path_provider/path_provider.dart';

class BerandaVIew extends StatefulWidget {
  @override
  _BerandaVIewState createState() => _BerandaVIewState();
}

class _BerandaVIewState extends State<BerandaVIew> {

  HomeBloc bloc = new HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // bloc.inboxNotif();
      // bloc.checkNotif();
      bloc.checkVerify();
      bloc.home(context);
    });

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      if (notification != null) {
        LocalData.haveNotif(true);
        bloc.setIndicatorNotif(true);
      }
    });

    // OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
    //   // will be called whenever a notification is received
    //   if (notification != null) {
    //     final data = notification.payload.additionalData;
    //     bloc.setIndicatorNotif(true);
    //     var type = data['notif'];
    //     if(type == 'notif'){
    //       bloc.setIndicatorNotif(true);
    //     }
    //   }
    // });

  }

  sendTestMessage() async{
    var hasPlayerId = await LocalData.getPlayerId();
    Map data = Map();
    data.putIfAbsent('type', () => 'notif');
    data.putIfAbsent('message', () => 'ini pesan nya');
    if(hasPlayerId != null){
      await OneSignal.shared.postNotification(OSCreateNotification(
          playerIds: [hasPlayerId],
          content: "Notif dari HP",
          heading: "ini pesan",
          // additionalData: data
        // buttons: [
        //   OSActionButton(text: "test1", id: "id1"),
        //   OSActionButton(text: "test2", id: "id2")
        // ]
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: bloc.dataHome,
          builder: (context, snapshot) {
            DataHome data;
            if(snapshot.data != null){
              data = snapshot.data;
            }
            return data != null ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    // height: is5Inc() ? size.height * 0.45:size.height * 0.42,
                    width: double.infinity,
                    color: Utils.colorFromHex(ColorCode.bluePrimary),
                    padding: EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        SizedBox(height: size.height * 0.05),
                        titleNotif(),
                        infoData(data)
                      ],
                    ),
                  ),
                  SizedBox(height: is5Inc() ? 15:30),
                  StreamBuilder(
                      stream: bloc.verifyOK,
                      builder: (context, snapshot) {
                        bool verify = bloc.verifikasi;
                        if(snapshot.data != null){
                          verify = snapshot.data;
                        }
                        return verify ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: infoBarcode(data.own),
                        ):SizedBox();
                      }
                  ),
                  (data != null && data.info != null) ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: data.info.isNotEmpty ? Column(
                      children: [
                        SizedBox(height: 10),
                        infoValidation(data.info),
                      ],
                    ):SizedBox(),
                  ):SizedBox(),
                  SizedBox(height: is5Inc() ? 15:30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Icon(Icons.map, color: Utils.colorFromHex(ColorCode.blueSecondary)),
                            Image.asset(ImageConstant.icBookOpen, height: 20, width: 20),
                            SizedBox(width: 10),
                            TextAvenir('Edukasi', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                          ],
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: loadItemEdukasi(data.edukasi),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: is5Inc() ? size.height * 0.15:0)
                ],
              ),
            ):BerandaShimmer();
          }
        ),
      ),
    );
  }

  loadItemEdukasi(List<ItemEdukasi> data){
    List<Widget> dataWidget = [];
    for(ItemEdukasi item in data){
      dataWidget.add(itemList(item));
    }
    return dataWidget;
  }

  loadArtikelShimmer(){
    List<Widget> dataWidget = [];
    for(int i=0; i<3; i++){
      dataWidget.add(shimmerArtikel());
    }
    return dataWidget;
  }

  titleNotif(){
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      TextAvenir('ELSIMIL',
                          size: size.width < 430 ? 19 : 24,
                          color: Utils.colorFromHex(ColorCode.lightBlueDark)),
                      Expanded(child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: ()=> Navigator.pushNamed(context, '/chat_screen').then((value){
                              bloc.inboxNotif();
                              // bloc.checkChat();
                            }),
                            child: StreamBuilder(
                              stream: bloc.haveChat,
                              builder: (context, snapshot) {
                                bool haveChat = false;
                                if(snapshot.data != null){
                                  haveChat = snapshot.data;
                                }
                                return Stack(
                                  children: [
                                    Padding(
                                      child: Image.asset(ImageConstant.icChat, height: is5Inc() ? 17:20, width: is5Inc() ? 17:20),
                                      padding: EdgeInsets.all(5),
                                    ),
                                    haveChat ? Positioned(
                                      right: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        height: is5Inc() ? 10:10,
                                        width: is5Inc() ? 10:10,
                                      ),
                                    ):SizedBox()
                                  ],
                                );
                              }
                            ),
                            // child: Icon(Icons.chat_bubble, color: Colors.white, size: 20)
                          ),
                          SizedBox(width: 15),
                          InkWell(
                              onTap: ()=> Navigator.pushNamed(context, '/list_notif').then((value) => bloc.checkNotif()),
                              child: StreamBuilder(
                                stream: bloc.haveNotif,
                                builder: (context, snapshot) {
                                  bool haveNotif = false;
                                  if(snapshot.data != null){
                                    haveNotif = snapshot.data;
                                  }
                                  return Stack(
                                    children: [
                                      Icon(Icons.notifications, color: Colors.grey.shade400, size: is5Inc() ? 20:22),
                                      haveNotif ? Positioned(
                                        right: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          height: is5Inc() ? 10:10,
                                          width: is5Inc() ? 10:10,
                                        ),
                                      ):SizedBox()
                                    ],
                                  );
                                }
                              )
                          ),
                        ],
                      ))
                    ],
                  ),
                  TextAvenir('Cek Kesiapan Menikah dan Hamil', size: is5Inc() ? 13:14, color: Utils.colorFromHex(ColorCode.lightBlueDark))
                ],
              )
          ),
        ],
      ),
    );
  }

  infoData(DataHome data){
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: ItemQuiz(result: data.result)
          ),
          SizedBox(width: 10),
          Expanded(
              flex: 2,
              child: ItemInfoProfile(
                dataOwn: data.own,
                dataCouple: data.couple,
              )
          )
        ],
      ),
    );
  }

  infoValidation(List<ItemInfo> data){
    final size = MediaQuery.of(context).size;
    return Container(
      height: is5Inc() ? size.height * 0.073 : size.height * 0.07,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index){
          ItemInfo info = data[index];
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Utils.colorFromHex(ColorCode.yellow_light)
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: is5Inc() ? 8: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.info_outline_rounded, color: Utils.colorFromHex(ColorCode.yellowElsimil)),
                SizedBox(width: 15),
                Expanded(child: InkWell(
                  onTap: ()=>bloc.resendVerification(context, info.link, info.additional),
                  child: Html(
                    data: info.content != null ? info.content : '',
                    // defaultTextStyle: TextStyle(fontSize: is5Inc() ? 11: 13, fontFamily: 'Avenir-Book', color: Utils.colorFromHex(ColorCode.yellowElsimil)),
                  ),
                ))
              ],
            ),
          );
        }
      ),
    );
  }

  infoBarcode(Own data){
    return InkWell(
      onTap: ()=>dialogBarcode(data),
      child: Container(
        decoration: ConstantStyle.boxShadowButon(
          color: Utils.colorFromHex(ColorCode.bluePrimary),
          radius: 25,
          blurRadius: 9,
          spreadRadius: 0.5,
          colorShadow: Colors.grey.withOpacity(0.4),
          offset:  Offset(1,3)
        ),
        margin: EdgeInsets.symmetric(horizontal: is5Inc() ? 0:0),
        child: Row(
          children: [
            Expanded(child: Container(
              decoration: BoxDecoration(
                color: Utils.colorFromHex(ColorCode.lightBlueDark),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
              margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
              child: Center(
                child: TextAvenir('PROFILE ID : ${data.profile_id}'),
              ),
            )),
            SizedBox(width: 20),
            Container(
              margin: EdgeInsets.only(right: 25),
              child: Center(child: Icon(Icons.qr_code_outlined, size: 30, color: Utils.colorFromHex(ColorCode.lightBlueDark)))
            )
          ],
        ),
      ),
    );
  }

  dialogBarcode(Own data){
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
        context: context,
        builder: (contex){
          return RepaintBoundary(
            key: globalKey,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextAvenir('Profile ID', size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                    SizedBox(height: 3),
                    TextAvenir(data.profile_id, size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                    SizedBox(height: 10),
                    Container(
                      width: 200.0,
                      height: 200.0,
                      child: QrImage(
                        data: data.profile_id.toString(),
                        version: QrVersions.auto,
                        size: 200,
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                        onTap: ()=>captureQrcode(data.profile_id),
                        child: TextAvenir('Simpan QR Code', size: 14, color: Utils.colorFromHex(ColorCode.blueSecondary))
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Future<String> _getPath() {
    return ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
  }

  GlobalKey globalKey = new GlobalKey();
  captureQrcode(String param) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      // Directory extDir = await DownloadsPathProvider.downloadsDirectory;
      // String tempPath = extDir.path;
      String tempPath = await _getPath();
      var filePath = tempPath + '/${param}.png';

      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // final tempDir = await getTemporaryDirectory();
      // var tempDir = await getApplicationDocumentsDirectory();
      // final file = await new File('${tempDir.path}/image.png').create();
      final file = await new File(filePath).create();
      await file.writeAsBytes(pngBytes);

      if(file.existsSync()){
        Navigator.of(context).pop();
        Utils.showConfirmDialog(context, 'Informasi', "QR Code berhasil disimpan, apakah anda ingin melihatnya sekarang?", () {
          OpenFile.open(file.path);
        });
      }

      // final channel = const MethodChannel('channel:me.alfian.share/share');
      // channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }



  itemList(ItemEdukasi data){
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/detail_artikel', arguments: {'id': data.id.toString()});
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                // color: Colors.grey.withOpacity(0.5),
                color: Utils.colorFromHex(ColorCode.lightBlueDark),
                spreadRadius: 1.5,
                blurRadius: 4,
                offset: Offset(0,0), // changes position of shadow
              ),
            ]

        ),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: size.width * 0.35,
        child: Column(
          children: [
            Container(
              height: size.height * 0.16 ,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)
                  ),
                  // image: DecorationImage(
                  //     fit: BoxFit.cover,
                  //     image: NetworkImage(data.image)//ExactAssetImage(ImageConstant.logo)
                  // )
              ),
              child: CachedNetworkImage(
                placeholder: (context, url) => Center(
                  child: Image.asset(ImageConstant.placeHolderElsimil),
                ),
                imageUrl: data.image,
                imageBuilder: (context, imageProvider) => Container(
                  // width: size.height * 0.10,
                  height: size.height * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)
                    ),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAvenir(data.kategori, size: 11, color: Colors.grey),
                  SizedBox(height: 3),
                  TextAvenir(data.title, size: 13, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  shimmerArtikel(){
    final size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
        baseColor: Colors.grey[400],
        highlightColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,

          ),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          width: size.width * 0.35,
          height:  size.height * 0.20,
          // decoration: ConstantStyle.box_fill_blu,
          // margin: EdgeInsets.symmetric(horizontal: is5Inc() ? 0:0),
        ));
  }

  is5Inc(){
    var size = MediaQuery.of(context).size;
    if(size.height < 650){
      return true;
    }else{
      return false;
    }
  }
}
