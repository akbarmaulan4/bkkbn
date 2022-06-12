import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:kua/bloc/baduta/baduta_controller.dart';
import 'package:kua/bloc/hamil/hamil_controller.dart';
import 'package:kua/bloc/home/home_bloc.dart';
import 'package:kua/model/home/data_home.dart';
import 'package:kua/model/home/item_edukasi.dart';
import 'package:kua/model/home/own.dart';
import 'package:kua/model/home/quiz/item_summary_quiz.dart';
import 'package:kua/model/user/user.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/util/local_data.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shimmer/shimmer.dart';

class NewBerandaView extends StatefulWidget {
  @override
  _NewBerandaViewState createState() => _NewBerandaViewState();
}

class _NewBerandaViewState extends State<NewBerandaView> {

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int get currentPage => _currentPage;

  final _selected = PublishSubject<int>();
  Stream<int> get selected => _selected.stream;

  _onPageChanged(int index) {
    _currentPage = index;
    _selected.sink.add(index);
  }
  HomeBloc bloc = new HomeBloc();
  HamilController controller = HamilController();
  BadutaController badutaController = BadutaController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // bloc.inboxNotif();
      // bloc.checkNotif();
      bloc.checkVersion(context);
      bloc.checkVerify();
      bloc.home(context);
    });

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    badutaController.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    controller.messageError.listen((event) {
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

    controller.hamil.listen((data) {
      if(data){
        Navigator.of(context).pushNamed('/janin_screen');
      }else{
        Navigator.of(context).pushNamed('/hamil_screen');
      }
    });

    badutaController.baduta.listen((data) {
      if(data){
        Navigator.of(context).pushNamed('/riwayat_baduta_screen');
      }else{
        Navigator.of(context).pushNamed('/baduta_entrance');
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.dataHome,
        builder: (context, snapshot) {
          DataHome data;
          if(snapshot.data != null){
            data = snapshot.data;
          }
          return Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                    stream: bloc.dataUser,
                    builder: (context, snapshot) {
                      UserModel userModel;
                      if(snapshot.data != null){
                        userModel = snapshot.data;
                      }
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: Utils.colorFromHex(ColorCode.bluePrimary),
                            padding: EdgeInsets.only(bottom: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                SizedBox(height: size.height * 0.05),
                                titleNotif(userModel != null ? userModel.name:'', data),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          StreamBuilder(
                              stream: bloc.verifyOK,
                              builder: (context, snapshot) {
                                bool verify = bloc.verifikasi;
                                if(snapshot.data != null){
                                  verify = snapshot.data;
                                }
                                return !verify ? Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: notif(),
                                ):SizedBox();
                              }
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: cardCategory(
                                    label: 'Pendampingan Calon Pengantin',
                                    type: 'catin',
                                    male: false,
                                    onClick: (){
                                      Navigator.pushNamed(context, '/list_quiz');
                                    }
                                  )
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: cardCategory(
                                    label: 'Pendampingan Ibu Hamil',
                                    male: userModel != null && userModel.gender == '1',
                                    type: 'hamil',
                                    onClick: (){
                                      if(userModel.gender == '1'){
                                        Utils.alertError(context, 'Pendampingan Ibu Hamil dikhususkan pada perempuan saja', () { });
                                      }else{
                                        controller.getStatusHamil(context);
                                      }
                                    }
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: cardCategory(
                                      label: 'Pendampingan Baduta',
                                      male: userModel != null && userModel.gender == '1',
                                      type: 'baduta',
                                      onClick: (){
                                        // badutaController.getStatusBaduta(context);
                                        // Navigator.of(context).pushNamed('/baduta_entrance');
                                        if(userModel.gender == '1'){
                                          Utils.alertError(context, 'Pendampingan Baduta dikhususkan pada perempuan saja', () { });
                                        }else{
                                          badutaController.getStatusBaduta(context);
                                        }
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                  SizedBox(height: 20),
                  data != null ? StreamBuilder(
                    stream: selected,
                    builder: (context, snapshot) {
                      int pos = 0;
                      if(snapshot.data != null){
                        pos = snapshot.data;
                      }
                      return data.summarykuis.length > 0 ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: info(data, pos),
                      ):SizedBox();
                    }
                  ):SizedBox(),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextAvenir('Artikel', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                  ),
                  SizedBox(height: 10),
                  data != null ? Container(
                    padding: EdgeInsets.only(left: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: loadItemEdukasi(data.edukasi),
                      ),
                    ),
                  ):Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: loadArtikelShimmer(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
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

  loadItemEdukasi(List<ItemEdukasi> data){
    List<Widget> dataWidget = [];
    for(ItemEdukasi item in data){
      dataWidget.add(itemList(item));
    }
    return dataWidget;
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
                errorWidget: (context, url, error)=>Image.asset(ImageConstant.placeHolderElsimil),
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

  titleNotif(String name, DataHome data){
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
                      TextAvenir('Hi, Selamat Datang',
                          size: size.width < 430 ? 19 : 24,
                          color: Utils.colorFromHex(ColorCode.lightBlueDark)),
                      Expanded(child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: ()=> Navigator.pushNamed(context, '/list_notif').then((value) => bloc.checkNotif()),
                              child: Stack(
                                children: [
                                  Icon(Icons.notifications, color: Colors.grey.shade400, size: Utils.is5Inc(context) ? 20:22),
                                ],
                              )
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: ()=> Navigator.pushNamed(context, '/landing_chat', arguments: {'main':false}).then((value){
                              bloc.inboxNotif();
                            }),
                            child: Stack(
                              children: [
                                Padding(
                                  child: Image.asset(ImageConstant.chat_inactive, height: Utils.is5Inc(context) ? 15:18, width: Utils.is5Inc(context) ? 17:20),
                                  padding: EdgeInsets.all(5),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: ()=> dialogBarcode(data.own),
                            child: Stack(
                              children: [
                                Icon(Icons.qr_code, color: Colors.grey.shade400, size: Utils.is5Inc(context) ? 20:22),
                              ],
                            )
                          ),
                        ],
                      ))
                    ],
                  ),
                  TextAvenir(name, size: Utils.is5Inc(context) ? 13:14, color: Utils.colorFromHex(ColorCode.lightBlueDark))
                ],
              )
          ),
        ],
      ),
    );
  }

  notif(){
    return Container(
      decoration: ConstantStyle.boxButton(radius: 5, color: Utils.colorFromHex(ColorCode.lightBlueDark)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.baseline,
        // textBaseline: TextBaseline.alphabetic,
        children: [
          Icon(Icons.info_outline_rounded),
          SizedBox(width: 5),
          Expanded(child: Container(
            child: Text('Anda belum aktivasi email', style: TextStyle(fontSize: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),),
          )),
          InkWell(
            onTap: ()=>bloc.closeVerify(),
            child: Icon(Icons.close)
          )
        ],
      ),
    );
  }

  cardCategory({
    String label,
    String type,
    bool male, 
    Function onClick}){
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ()=>onClick(),
      child: Container(
        decoration: ConstantStyle.boxButton(radius: 10,
            color: getBgImgPlaceHolder(type, male)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // height: size.height * 0.16,
        height: size.height * 0.18,
        child: Column(
          children: [
            // label.contains('Pengantin') ? Image.asset(ImageConstant.placeholder_catin, height: size.height * 0.10,):
            // male ? Image.asset(ImageConstant.placeholder_hamil_inactive, height: size.height * 0.11,):
            // Image.asset(ImageConstant.placeholder_hamil, height: size.height * 0.11,),
            Image.asset(getImgPlaceHolder(type, male), height: size.height * 0.10,),
            // Image.asset(getImgPlaceHolder(type, male), height: size.height * 0.13,),
            SizedBox(height: 8),
            Center(
              child: TextAvenir(label, textAlign: TextAlign.center, size: 11,),
              // child: TextAvenir(label, textAlign: TextAlign.center, size: 12,),
            ),
          ],
        ),
      ),
    );
  }
  
  getImgPlaceHolder(String label, bool male){
    if(label == 'catin'){
      return ImageConstant.placeholder_catin;
    }else if(label == 'hamil' && male == true){
      return ImageConstant.placeholder_hamil_inactive;
    }else if(label == 'hamil' && male == false){
      return ImageConstant.placeholder_hamil;
    }else if(label == 'baduta' && male == false){
      return ImageConstant.placeholder_baduta;
    }else if(label == 'baduta' && male == true){
      return ImageConstant.placeholder_baduta_inactive;
    }
  }

  getBgImgPlaceHolder(String label, bool male){
    if(label == 'catin'){
      return Utils.colorFromHex(ColorCode.bgCatin);
    }else if(label == 'hamil' && male == false){
      return Utils.colorFromHex(ColorCode.bgHamil);
    }else if(label == 'baduta' && male == false){
      return Utils.colorFromHex(ColorCode.bgBaduta);
    }else{
      return Colors.grey.shade200;
    }
  }

  info(DataHome data, int pos){
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: AssetImage(ImageConstant.bg_banner),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: size.height * 0.09,
      child: Row(
        children: [
          InkWell(
            onTap: (){
              _pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: Icon(Icons.chevron_left_rounded)
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.summarykuis.length,
                  controller: _pageController,
                  // onPageChanged: _onPageChanged,
                  itemBuilder: (context, index){
                    ItemSummaryQuiz info = data.summarykuis[index];
                    return Center(
                      child: TextAvenir(info.message),
                    );
                  }
              ),
            )
          ),
          InkWell(
            onTap: (){
              if(data.summarykuis.length > pos)
              _pageController.animateToPage(
                pos+1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: Icon(Icons.chevron_right_rounded)
          )
        ],
      ),
    );
  }

  loadArtikelShimmer(){
    List<Widget> dataWidget = [];
    for(int i=0; i<3; i++){
      dataWidget.add(shimmerArtikel());
    }
    return dataWidget;
  }

  shimmerArtikel(){
    final size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
        baseColor: Utils.colorFromHex('#dfdfdf'),
        highlightColor: Utils.colorFromHex('#eeeeee'),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Utils.colorFromHex('#dfdfdf'),

          ),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          width: size.width * 0.35,
          height:  size.height * 0.20,
          // decoration: ConstantStyle.box_fill_blu,
          // margin: EdgeInsets.symmetric(horizontal: is5Inc() ? 0:0),
        ));
  }
}
