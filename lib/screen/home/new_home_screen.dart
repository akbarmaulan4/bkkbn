import 'package:flutter/material.dart';
import 'package:kua/bloc/home/home_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'akun/akun_view.dart';
import 'beranda/chat/landing_chat_screen.dart';
import 'beranda/new_beranda_view.dart';
import 'edukasi/edukasi_view.dart';

class NewHomeScreen extends StatefulWidget {
  int? loadFirstMenu;
  NewHomeScreen({this.loadFirstMenu});
  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {

  HomeBloc bloc = new HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initOneSignal();

    // OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
    //   // will be called whenever a notification is received
    //   if (notification != null) {
    //     final data = notification.payload.additionalData;
    //   }
    // });

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      final data = result.notification.additionalData;
      // will be called whenever a notification is opened/button pressed.
    });

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });
  }

  initOneSignal(){
    // WidgetsFlutterBinding.ensureInitialized();
    // OneSignal.shared.init("6d354bb7-68f2-436a-9fd0-24e003384003",
    //     iOSSettings: {
    //       OSiOSSettings.autoPrompt: false,
    //       OSiOSSettings.inAppLaunchUrl: false
    //     });
    // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    WidgetsFlutterBinding.ensureInitialized();
    OneSignal.shared.setAppId('6d354bb7-68f2-436a-9fd0-24e003384003');
    setupPlayerId();
  }

  void setupPlayerId() async {
    var status = await OneSignal. shared.getDeviceState();
    var playerId = status!.userId;
    // var status = await OneSignal.shared.getPermissionSubscriptionState();
    // var playerId = status.subscriptionStatus.userId;
    // if (playerId != null) {
    //
    // }
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
    return WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Scaffold(
        body: StreamBuilder(
            stream: bloc.viewScreen,
            builder: (context, snapshot) {
              int view = widget.loadFirstMenu as int;
              if(snapshot.data != null){
                view = snapshot.data as int;
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
                view = snapshot.data as int;
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
                  children: [//new
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
      case 1:
        return EdukasiView();
      case 2:
        return AkunView();
      case 3:
        return LandingScreen(true);
      default:
        return NewBerandaView();
    }
  }
}
