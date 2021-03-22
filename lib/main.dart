import 'package:flutter/material.dart';
import 'package:kua/model/quiz/submit/result/result_submit.dart';
import 'package:kua/screen/auth/forgotpassword/forgot_password_screen.dart';
import 'package:kua/screen/auth/forgotpassword/otp_password_screen.dart';
import 'package:kua/screen/auth/login/login_screen.dart';
import 'package:kua/screen/auth/register/register_screen.dart';
import 'package:kua/screen/gateway/gateway_screen.dart';
import 'package:kua/screen/home/edukasi/detail_artikel.dart';
import 'package:kua/screen/home/edukasi/list_artikel.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/screen/home/beranda/chat/chat_screen.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/screen/home/beranda/notif/list_notif.dart';
import 'package:kua/screen/home/home_screen.dart';
import 'package:kua/screen/home/kuesioner/generate_quiz.dart';
import 'package:kua/screen/home/kuesioner/landing_quiz.dart';
import 'package:kua/screen/home/kuesioner/pdfview.dart';
import 'package:kua/screen/home/kuesioner/result_quiz.dart';
import 'package:kua/screen/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
            return MaterialPageRoute(
                builder: (context){
                  return HomeScreen();
                },
                settings: RouteSettings());
          case '/landing_quiz':
            Map<String, dynamic> arguments = null;
            if (initial.arguments is Map<String, dynamic>) {
              arguments = initial.arguments as Map<String, dynamic>;
            }
            return MaterialPageRoute(
                builder: (context) {
                  return LandingQuiz(arguments["id"]);
                },
                settings: RouteSettings());
          case '/generate_quiz':
            Map<String, dynamic> arguments = null;
            if (initial.arguments is Map<String, dynamic>) {
              arguments = initial.arguments as Map<String, dynamic>;
            }
            return MaterialPageRoute(
                builder: (context){
                  return GenerateQuiz(arguments["id"]);
                },
                settings: RouteSettings());
          case '/result_quiz':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return ResultQuiz(arguments['data']);
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
          case '/chat_screen':
            return MaterialPageRoute(
                builder: (context) {
                  Map<String, dynamic> arguments = null;
                  if (initial.arguments is Map<String, dynamic>) {
                    arguments = initial.arguments as Map<String, dynamic>;
                  }
                  return ChatScreen();
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
                    data: arguments['data'],
                  );
                },
                settings: RouteSettings());
          default: return null;
        }
      },
    );
  }
}
