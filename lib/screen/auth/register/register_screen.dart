import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/screen/auth/register/register_data.dart';
import 'package:kua/screen/auth/register/register_data_diri.dart';
import 'package:kua/screen/auth/register/register_foto.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  AuthBloc bloc = new AuthBloc();

  Future<bool> onWillPop() {
    if((bloc.registViewAt-1) < 0){
      Navigator.of(context).pushNamedAndRemoveUntil('/gateway', (Route<dynamic> route) => false);
    }else{
      bloc.changeViewRegist(bloc.registViewAt-1);
      return Future.value(false);
    }
  }

  is5Inc(){
    var size = MediaQuery.of(context).size;
    if(size.height < 650){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   centerTitle: true,
        //   leading: InkWell(
        //     onTap: ()=>Navigator.of(context).pushNamedAndRemoveUntil('/gateway', (Route<dynamic> route) => false),
        //     child: Icon(Icons.arrow_back_rounded, color: Colors.black87,)
        //   ),
        //   bottom: PreferredSize(
        //       child: Container(
        //         color: Utils.colorFromHex(ColorCode.lightBlueDark),
        //         height: 1,
        //       ),
        //       preferredSize: Size.fromHeight(4.0))
        // ),
        body: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.06,),
                // Text("REGISTRASI", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: ()=>Navigator.of(context).pushNamedAndRemoveUntil('/gateway', (Route<dynamic> route) => false),
                    child: Align(
                      alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary), size: 20,)),
                  ),
                ),
                SizedBox(height: 10),
                TextAvenir(
                  'REGISTRASI',
                  size: 24,
                  color: Utils.colorFromHex(ColorCode.bluePrimary),
                ),
                SizedBox(height: 25),
                StreamBuilder(
                  stream: bloc.regisScreen,
                  builder: (context, snapshot) {
                    int screenAt = bloc.registViewAt;
                    if(snapshot.data != null){
                      screenAt = snapshot.data;
                    }
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 3, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color:Utils.colorFromHex(ColorCode.bluePrimary),
                                    ),
                                  )
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: screenAt > 1 ? Utils.colorFromHex(ColorCode.bluePrimary) : Colors.grey[300],
                                    ),
                                  )
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: screenAt > 2 ? Utils.colorFromHex(ColorCode.bluePrimary) : Colors.grey[300],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        loadScreenRegist(screenAt)
                      ],
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadScreenRegist(int val){
    switch(val){
      case 0:
        return RegisterData(
          bloc: bloc,
        );
      case 1:
        return RegisterFoto(
          bloc: bloc,
        );
      case 2:
        return RegisterDataDiri(
          bloc: bloc,
        );
      default:
        return RegisterData(
          bloc: bloc,
        );
    }
  }

  body(){
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset(ImageConstant.lpRegister, height: size.height * 0.30,)),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[100]
            // border: Border.all(color: Colors.blue[100])
          ),
          padding: EdgeInsets.only(right: 25),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Nama Lengkap',
              fillColor: Colors.blue[100],
              prefixIcon: Icon(Icons.person, size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary)),
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[100]
            // border: Border.all(color: Colors.blue[100])
          ),
          padding: EdgeInsets.only(right: 25),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'No Telepon',
              fillColor: Colors.blue[100],
              prefixIcon: Icon(Icons.phone, size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary)),
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[100]
            // border: Border.all(color: Colors.blue[100])
          ),
          padding: EdgeInsets.only(right: 25),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Jenis Kelamain',
              fillColor: Colors.blue[100],
              prefixIcon: Icon(Icons.wc, size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary)),
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[100]
            // border: Border.all(color: Colors.blue[100])
          ),
          padding: EdgeInsets.only(right: 25),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'NIK(KTP/SIM)',
              fillColor: Colors.blue[100],
              prefixIcon: Icon(Icons.credit_card, size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary)),
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[100]
            // border: Border.all(color: Colors.blue[100])
          ),
          padding: EdgeInsets.only(right: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 15, top: 10, right: 15),
                  child: Icon(Icons.home, size: 18, color: Utils.colorFromHex(ColorCode.bluePrimary))
              ),
              Expanded(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Alamat',
                    fillColor: Colors.blue[100],
                    // icon: Icon(Icons.home, size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary))
                    // prefixIcon: Icon(Icons.home, size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[100]
            // border: Border.all(color: Colors.blue[100])
          ),
          padding: EdgeInsets.only(right: 25),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Nama Pasangan',
              fillColor: Colors.blue[100],
              prefixIcon: Icon(Icons.person_outline, size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary)),
            ),
          ),
        ),
        SizedBox(height: 15),
        Divider(),
        Text('Untuk melengkapi data diri anda silahkan upload beberapa file dibawah ini',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Utils.colorFromHex(ColorCode.bluePrimary))),
        SizedBox(height: 15),
        Text('Foto KTP/SIM', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
        SizedBox(height: 8),
        InkWell(
          onTap: ()=>Navigator.pushNamed(context, '/camera'),
          child: Container(
            width: double.infinity,
            height: size.height * 0.25,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1,1), // changes position of shadow
                  ),
                ]
            ),
            child: Center(child: Image.asset(ImageConstant.fotoIcon, height: size.height * 0.10,)),
          ),
        ),
        SizedBox(height: size.height * 0.05),
      ],
    );
  }
}
