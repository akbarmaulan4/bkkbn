import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/home/home_bloc.dart';
import 'package:kua/screen/home/akun/akun_view.dart';
import 'package:kua/screen/home/beranda/beranda_view.dart';
import 'package:kua/screen/home/edukasi/edukasi_view.dart';
import 'package:kua/screen/home/kuesioner/list_quiz_view.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeBloc bloc = new HomeBloc();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()=> null,
      child: Scaffold(
        body: StreamBuilder(
          stream: bloc.viewScreen,
          builder: (context, snapshot) {
            int view = 0;
            if(snapshot.data != null){
              view = snapshot.data;
            }
            return Container(
              child: loadView(view),
            );
          }
        ),
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Utils.colorFromHex(ColorCode.blueSecondary)
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: InkWell(
                  onTap: ()=>bloc.changeScreen(0),
                  child: Column(
                    children: [
                      Icon(Icons.home, color: Colors.white,),
                      Text('Beranda', style: TextStyle(fontSize: 13, color: Colors.white))
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
                      Icon(Icons.lightbulb_outline_rounded, color: Colors.white,),
                      Text('Kuesioner', style: TextStyle(fontSize: 13, color: Colors.white),)
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
                      Icon(Icons.workspaces_outline, color: Colors.white,),
                      Text('Berita', style: TextStyle(fontSize: 13, color: Colors.white),)
                    ],
                  ),
                )
              ),
              Expanded(
                flex: 4,
                child: InkWell(
                  onTap: ()=>bloc.changeScreen(3),
                  child: Column(
                    children: [
                      Icon(Icons.person_pin, color: Colors.white,),
                      Text('Akun', style: TextStyle(fontSize: 13, color: Colors.white),)
                    ],
                  ),
                )
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
  

  
  loadView(int val){
    switch(val){
      case 0:
        return BerandaVIew();
      case 1:
        return ListQuizView();
      case 2:
        return EdukasiView();
      case 3:
        return AkunView();
      default:
        return BerandaVIew();
    }
  }
}
