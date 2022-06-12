import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:kua/screen/auth/forgotpassword/forgot_password_screen.dart';
import 'package:kua/screen/auth/forgotpassword/otp_password_screen.dart';
import 'package:kua/screen/auth/login/login_screen.dart';
import 'package:kua/screen/auth/register/register_screen.dart';
import 'package:kua/screen/baduta/baduta_entrance_screen.dart';
import 'package:kua/screen/baduta/detail_riwayat_baduta_screen.dart';
import 'package:kua/screen/baduta/riwayat_baduta_screen.dart';
import 'package:kua/screen/gateway/gateway_screen.dart';
import 'package:kua/screen/hamil/detail_riwayat_janin_screen.dart';
import 'package:kua/screen/hamil/hamil_entrance_screen.dart';
import 'package:kua/screen/hamil/janin_entrance_screen.dart';
import 'package:kua/screen/hamil/riwayat_janin_screen.dart';
import 'package:kua/screen/home/akun/bantuan/detail_bantuan.dart';
import 'package:kua/screen/home/akun/bantuan/list_bantuan.dart';
import 'package:kua/screen/home/akun/bantuan/web_screen.dart';
import 'package:kua/screen/home/akun/biodata/biodata_screen.dart';
import 'package:kua/screen/home/akun/biodata/biodata_spouse.dart';
import 'package:kua/screen/home/akun/biodata/tambah_pasangan.dart';
import 'package:kua/screen/home/akun/password/ubah_password.dart';
import 'package:kua/screen/home/akun/riwayat/detail_riwayat.dart';
import 'package:kua/screen/home/akun/riwayat/riwayat.dart';
import 'package:kua/screen/home/akun/riwayat/riwayat_pasangan.dart';
import 'package:kua/screen/home/beranda/chat/chat_screen.dart';
import 'package:kua/screen/home/beranda/chat/landing_chat_screen.dart';
import 'package:kua/screen/home/edukasi/detail_artikel.dart';
import 'package:kua/screen/home/edukasi/list_artikel.dart';
import 'package:kua/screen/home/home_screen.dart';
import 'package:kua/screen/home/kuesioner/edit_quiz.dart';
import 'package:kua/screen/home/kuesioner/generate_quiz.dart';
import 'package:kua/screen/home/kuesioner/landing_quiz.dart';
import 'package:kua/screen/home/kuesioner/list_quiz_view.dart';
import 'package:kua/screen/home/kuesioner/pdfview.dart';
import 'package:kua/screen/home/kuesioner/result_quiz.dart';
import 'package:kua/screen/home/new_home_screen.dart';
import 'package:kua/screen/splash/splash_screen.dart';

import 'screen/home/beranda/notif/list_notif.dart';

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//   // FlavorConfig(
//   //   name: "Elsimil-DEV",
//   //   color: Colors.red,
//   //   location: BannerLocation.bottomStart,
//   //   variables: {
//   //     // "counter": 5,
//   //     "baseUrl": 'http://elsimil-test.axara.co.id/api/v1',
//   //   },
//   // );
//   // FlavorConfig(
//   //   name: "Elsimil",
//   //   color: Colors.red,
//   //   location: BannerLocation.bottomStart,
//   //   variables: {
//   //     // "counter": 5,
//   //     "baseUrl": 'https://elsimil.bkkbn.go.id/api/v1',
//   //   },
//   // );
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elsimil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      onGenerateRoute: (initial){
        switch(initial.name){
          case '/gateway':
            return MaterialPageRoute(
                builder: (context){
                  return GatewayScreen();
                },
                settings: RouteSettings());
          case '/login':
            return MaterialPageRoute(
                builder: (context){
                  return LoginScreen();
                },
                settings: RouteSettings());
          case '/forgot_password':
            return MaterialPageRoute(
                builder: (context){
                  return ForgotPasswordScreen();
                },
                settings: RouteSettings());
          case '/otp_password':
            return MaterialPageRoute(
                builder: (context){
                  return OTPPasswordScreen();
                },
                settings: RouteSettings());
          case '/register':
            return MaterialPageRoute(
                builder: (context){
                  return RegisterScreen();
                },
                settings: RouteSettings());
          case '/home':
            Map<String, dynamic> arguments = null;
            if (initial.arguments is Map<String, dynamic>) {
              arguments = initial.arguments as Map<String, dynamic>;
            }
            return MaterialPageRoute(
                builder: (context) {
                  // return HomeScreen(loadFirstMenu: arguments["loadFirstMenu"],);
                  return NewHomeScreen(loadFirstMenu: arguments["loadFirstMenu"],);
                },
                settings: RouteSettings());
          case '/landing_quiz':
            Map<String, dynamic> arguments = null;
            if (initial.arguments is Map<String, dynamic>) {
              arguments = initial.arguments as Map<String, dynamic>;
            }
            return MaterialPageRoute(
                builder: (context) {
                  return LandingQuiz(id: arguments["id"], result_id: arguments["result_id"],);
                },
                settings: RouteSettings());
          case '/generate_quiz':
            Map<String, dynamic> arguments = null;
            if (initial.arguments is Map<String, dynamic>) {
              arguments = initial.arguments as Map<String, dynamic>;
            }
            return MaterialPageRoute(
                builder: (context){
                  return GenerateQuiz(arguments["id"], arguments["title"]);
                },
                settings: RouteSettings());
          case '/result_quiz':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return ResultQuiz(arguments['data'], arguments['isEdit'], arguments['title']);
                },
                settings: RouteSettings());
          case '/pdf':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return Pdfview(arguments['url'], arguments['code']);
                },
                settings: RouteSettings());

          case '/list_notif':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return ListNotif();
                },
                settings: RouteSettings());
          case '/landing_chat':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return LandingScreen(arguments['main']);
                },
                settings: RouteSettings());
          case '/chat_screen':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return ChatScreen(data: arguments['data']);
                },
                settings: RouteSettings());
          case '/list_artikel':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return ListArtikel(
                    data: arguments['data'],
                  );
                },
                settings: RouteSettings());
          case '/detail_artikel':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return DetailArtikel(
                    id: arguments['id'],
                  );
                },
                settings: RouteSettings());

          case '/biodata':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return BiodataView();
                },
                settings: RouteSettings());
          case '/biodata_pasangan':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return BiodataSpouse();
                },
                settings: RouteSettings());
          case '/tambah_pasangan':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return TambahPasangan();
                },
                settings: RouteSettings());
          case '/bantuan':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return ListBantuan();
                },
                settings: RouteSettings());
          case '/detail_bantuan':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return DetailBantuan(data: arguments['data']);
                },
                settings: RouteSettings());
          case '/web_screen':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return WebScreen(title: arguments['title'],url: arguments['url'],);
                },
                settings: RouteSettings());
          case '/riwayat':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return Riwayat();
                },
                settings: RouteSettings());
          case '/detail_riwayat':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return DetailRiwayat(id: arguments['id'], title: arguments['title'],);
                },
                settings: RouteSettings());
          case '/edit_quiz':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return EditQuiz(arguments['id'], arguments["title"]);
                },
                settings: RouteSettings());
          case '/riwayat_pasangan':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return RiwayatPasangan(arguments['id']);
                },
                settings: RouteSettings());
          case '/ubah_password':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return UbahPassword();
                },
                settings: RouteSettings());
          case '/hamil_screen':
            return MaterialPageRoute(
                builder: (context){
                  return HamilEntranceScreen();
                },
                settings: RouteSettings());
          case '/janin_screen':
            return MaterialPageRoute(
                builder: (context){
                  return JaninEntranceScreen();
                },
                settings: RouteSettings());
          case '/riwayat_janin_screen':
            return MaterialPageRoute(
                builder: (context){
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return RiwayatJaninScreen(idJanin: arguments['idJanin']);
                },
                settings: RouteSettings());
          case '/detail_riwayat_janin_screen':
            return MaterialPageRoute(
                builder: (context){
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return DetailRiwayatJaninScreen(idJanin: arguments['idJanin'], quizHamilId: arguments['quizId'],);
                },
                settings: RouteSettings());
          case '/list_quiz':
            return MaterialPageRoute(
                builder: (context){
                  return ListQuizView();
                },
                settings: RouteSettings());
          case '/baduta_entrance':
            return MaterialPageRoute(
                builder: (context){
                  return BadutaEntranceScreen();
                },
                settings: RouteSettings());
          case '/riwayat_baduta_screen':
            return MaterialPageRoute(
                builder: (context){
                  return RiwayatBadutaScreen();
                },
                settings: RouteSettings());
          case '/detail_riwayat_baduta_screen':
            return MaterialPageRoute(
                builder: (context){
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return DetailRiwayatBadutaScreen(arguments['badutaID']);
                },
                settings: RouteSettings());
          default: return null;
        }
      },
    );
  }
}

class EnvironmentConfig {
  static Environment environment;
}

enum Environment { dev, prod }
