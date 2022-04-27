import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/home/home_bloc.dart';
import 'package:kua/screen/home/akun/akun_view.dart';
import 'package:kua/screen/home/beranda/beranda_view.dart';
import 'package:kua/screen/home/beranda/new_beranda_view.dart';
import 'package:kua/screen/home/edukasi/edukasi_view.dart';
import 'package:kua/screen/home/kuesioner/list_quiz_view.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/util/local_data.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'beranda/chat/landing_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  int loadFirstMenu;
  HomeScreen({this.loadFirstMenu});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeBloc bloc = new HomeBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initOneSignal();
    OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
      // will be called whenever a notification is received
      if (notification != null) {
        final data = notification.payload.additionalData;
      }
    });

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });
  }

  initOneSignal(){
    WidgetsFlutterBinding.ensureInitialized();
    OneSignal.shared.init("6d354bb7-68f2-436a-9fd0-24e003384003",
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: false
        });
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    setupPlayerId();
  }

  void setupPlayerId() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    var playerId = status.subscriptionStatus.userId;
    if (playerId != null) {

    }
    // var hasPlayerId = await LocalData.getPlayerId();
    // if (!hasPlayerId) {
    //   var status = await OneSignal.shared.getPermissionSubscriptionState();
    //   var playerId = status.subscriptionStatus.userId;
    //   if (playerId != null) {
    //     bloc.postPlayerId(playerId);
    //   } else {
    //     setupPlayerId();
    //   }
    // }

   // await OneSignal.shared.postNotification(OSCreateNotification(
   //     // playerIds: [playerId],
   //     content: "this is a test from OneSignal's Flutter SDK",
   //     heading: "Test Notification",
   //     buttons: [
   //       OSActionButton(text: "test1", id: "id1"),
   //       OSActionButton(text: "test2", id: "id2")
   //     ]
   // ));

//    var myCustomUniqueUserId = "something from my backend server";
//    OneSignal.shared.setExternalUserId(myCustomUniqueUserId);
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()=> null,
      child: Scaffold(
        body: StreamBuilder(
          stream: bloc.viewScreen,
          builder: (context, snapshot) {
            int view = widget.loadFirstMenu;
            if(snapshot.data != null){
              view = snapshot.data;
            }
            return Container(
              child: loadView(view),
            );
          }
        ),
        floatingActionButton: StreamBuilder(
          stream: bloc.viewScreen,
          builder: (context, snapshot) {
            int view = 0;
            if(snapshot.data != null){
              view = snapshot.data;
            }
            return bottomMenu(view);
          }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  bottomMenu(int position){
    return Container(
      alignment: Alignment.bottomCenter,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(45)),
          color: Utils.colorFromHex(ColorCode.blueSecondary),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              // color: Colors.grey[200],
              spreadRadius: 7,
              blurRadius: 7,
              offset: Offset(0,0),
            ),
          ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: InkWell(
                onTap: ()=>bloc.changeScreen(0),
                child: Column(
                  children: [
                    Image.asset(position == 0 ? ImageConstant.home_active:ImageConstant.home_inactive, height: 24, width: 24,),
                    Text('Beranda', style: TextStyle(fontSize: 13, color: position == 0 ? Colors.white : Utils.colorFromHex(ColorCode.lightGreyElsimil)), textScaleFactor: 1.0,)
                  ],
                ),
              )
          ),
          Expanded(
              flex: 4,
              child: InkWell(
                onTap: ()=>bloc.changeScreen(1),
                child: Column(
                  children: [
                    Image.asset(position == 1 ? ImageConstant.edukasi_active:ImageConstant.edukasi_inactive, height: 24, width: 24,),
                    Text('Edukasi', style: TextStyle(fontSize: 13, color: position == 1 ? Colors.white:Utils.colorFromHex(ColorCode.lightGreyElsimil)), textScaleFactor: 1.0,)
                    // Icon(Icons.lightbulb_outline_rounded, color: position == 1 ? Utils.colorFromHex(ColorCode.lightGreyElsimil) : Colors.white ),
                    // Text('Kuesioner', style: TextStyle(fontSize: 13, color: position == 1 ? Utils.colorFromHex(ColorCode.lightGreyElsimil) : Colors.white), textScaleFactor: 1.0,)
                  ],
                ),
              )
          ),
          Expanded(
              flex: 4,
              child: InkWell(
                onTap: ()=>bloc.changeScreen(2),
                child: Column(
                  children: [
                    Image.asset(position == 2 ? ImageConstant.akun_active:ImageConstant.akun_inactive, height: 24, width: 24,),
                    Text('Akun', style: TextStyle(fontSize: 13, color: position == 2 ? Colors.white:Utils.colorFromHex(ColorCode.lightGreyElsimil)), textScaleFactor: 1.0,)
                  ],
                ),
              )
          ),
          Container(
            width: 1,
            margin: EdgeInsets.only(bottom: 5),
            color: Utils.colorFromHex(ColorCode.lightBlueDark),
          ),
          Expanded(
              flex: 4,
              child: InkWell(
                onTap: ()=>bloc.changeScreen(3),
                child: Column(
                  children: [
                    // Icon(Icons.person_pin, color: position == 3 ? Utils.colorFromHex(ColorCode.lightGreyElsimil) : Colors.white ),
                    Image.asset(position == 3 ? ImageConstant.chat_active:ImageConstant.chat_inactive, height: 24, width: 24,),
                    Text('Chat', style: TextStyle(fontSize: 13, color: position == 3 ? Colors.white:Utils.colorFromHex(ColorCode.lightGreyElsimil)), textScaleFactor: 1.0,)
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
  

  
  loadView(int val){
    switch(val){
      case 0:
        return NewBerandaView();
        // return BerandaVIew();
      case 1:
        return EdukasiView();
        // return ListQuizView();
      case 2:
        return AkunView();
        // return EdukasiView();
      case 3:
        return LandingScreen(true);
      default:
        return BerandaVIew();
    }
  }
}
