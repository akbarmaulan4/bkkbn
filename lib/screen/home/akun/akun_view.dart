import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/akun/akun_bloc.dart';
import 'package:kua/model/user/user.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/util/local_data.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:shimmer/shimmer.dart';

class AkunView extends StatefulWidget {
  @override
  _AkunScreenState createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunView> {
  AkunBloc bloc = AkunBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   loadData();
  }

  loadData() async {
    var user = await LocalData.getUser();
    bloc.getProfile(user.id.toString());
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextAvenir('AKUN', size: is5Inc() ? 17:20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
            child: Container(
              color: Utils.colorFromHex(ColorCode.lightBlueDark),
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(4.0))
      ),
      body: StreamBuilder<Object>(
        stream: bloc.dataUser,
        builder: (context, snapshot) {
          Map user;
          if(snapshot.data != null){
            user = snapshot.data;
          }
          return user != null ? Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Utils.colorFromHex(ColorCode.softGreyElsimil),
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: is5Inc() ?  size.height * 0.02:size.height * 0.04),
                  Column(
                    children: [
                      Center(
                        child: Container(
                          height: is5Inc() ? 55:64,
                          width: is5Inc() ? 55:64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Center(
                                child: Image.asset(ImageConstant.placeHolderElsimil),
                              ),
                              imageUrl: user != null ? user['pic']:'', //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2U_L6KJsOv1ZX5v-JScbk8ZO_ZEe5CwOvmA&usqp=CAU',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextAvenir(user  != null ? user['nama'] : '', size: is5Inc() ? 18:24, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                      SizedBox(height: is5Inc() ?4:7),
                      TextAvenirBook(user  != null ? '${user['umur']},${user['kota']}':'', size: is5Inc() ? 12:14, color: Utils.colorFromHex(ColorCode.lightGreyElsimil)),
                      SizedBox(height: 3),
                      RichText(
                        textScaleFactor: 1.0,
                        text: TextSpan(
                          text: 'PROFILE ID : ',
                          style: TextStyle(height: 1.5, fontSize: is5Inc() ?10:12, fontFamily: 'Avenir', color: Utils.colorFromHex(ColorCode.lightGreyElsimil)),
                          children: <TextSpan>[
                            TextSpan(text: user  != null ? user['profile_id'] : '', style: TextStyle(height: 1.5, fontSize: is5Inc() ? 10:12, fontFamily: 'Avenir', color: Colors.grey)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/biodata').then((value) => loadData());
                    },
                    child: itemList('Perbaharui Biodata'),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/biodata_pasangan');
                    },
                    child: itemList('Biodata Pasangan'),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: ()=> Navigator.pushNamed(context, '/riwayat'),
                    child: itemList('Riwayat Kuesioner'),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: ()=>Navigator.pushNamed(context, '/bantuan'),
                    child: itemList('Bantuan'),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: ()=>Navigator.pushNamed(context, '/ubah_password'),
                    child: itemList('Ubah Kata Sandi'),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: (){
                      Utils.dialogMessage(
                        context: context,
                        title: 'Apakah anda ingin keluar aplikasi?',
                        ok: (){
                          LocalData.removeAllPreference();
                          Navigator.of(context).pushNamedAndRemoveUntil('/gateway', (Route<dynamic> route) => false);
                        }
                      );
                    },
                    child: itemList('Keluar'),
                  ),
                  SizedBox(height: is5Inc() ? size.height * 0.15:0,)
                ],
              ),
            ),
          ):shimmerAkun();
        }
      ),
    );
  }

  itemList(String title){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Utils.colorFromHex(ColorCode.lightBlueDark))
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        children: [
          Expanded(
              child: TextAvenir(title, size: 14, color: Utils.colorFromHex(ColorCode.blueSecondary))
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Utils.colorFromHex(ColorCode.blueSecondary))
        ],
      ),
    );
  }

  shimmerAkun(){
    final size = MediaQuery.of(context).size;
    return Container(
      color: Utils.colorFromHex('#f2f2f2'),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: is5Inc() ?  size.height * 0.02:size.height * 0.04),
          Center(
            child: Shimmer.fromColors(child: Container(
              height: is5Inc() ? 55:64,
              width: is5Inc() ? 55:64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Utils.colorFromHex('#dfdfdf'),
              ),
            ),
            baseColor: Utils.colorFromHex('#dfdfdf'),
            highlightColor: Utils.colorFromHex('#eeeeee')),
          ),
          SizedBox(height: 10),
          Shimmer.fromColors(child: Container(
            height: size.height * 0.03,
            width: size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Utils.colorFromHex('#dfdfdf'),
            ),
          ),
          baseColor: Utils.colorFromHex('#dfdfdf'),
          highlightColor: Utils.colorFromHex('#eeeeee')),
          SizedBox(height: is5Inc() ? 5:10),
          Shimmer.fromColors(child: Container(
            height: size.height * 0.02,
            width: size.width * 0.50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Utils.colorFromHex('#dfdfdf'),
            ),
          ),
          baseColor: Utils.colorFromHex('#dfdfdf'),
          highlightColor: Utils.colorFromHex('#eeeeee')),
          // SizedBox(height: 3),
          // Shimmer.fromColors(child: Container(
          //   height: size.height * 0.02,
          //   width: size.width * 0.50,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(5)),
          //     color: Utils.colorFromHex('#dfdfdf'),
          //   ),
          // ),
          // baseColor: Utils.colorFromHex('#dfdfdf'),
          // highlightColor: Utils.colorFromHex('#eeeeee')),
          SizedBox(height: 40),
          Shimmer.fromColors(child: Container(
            height: size.height * 0.07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Utils.colorFromHex('#dfdfdf'),
            ),
          ),
          baseColor: Utils.colorFromHex('#dfdfdf'),
          highlightColor: Utils.colorFromHex('#eeeeee')),
          SizedBox(height: 20),
          Shimmer.fromColors(child: Container(
            height: size.height * 0.07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Utils.colorFromHex('#dfdfdf'),
            ),
          ),
          baseColor: Utils.colorFromHex('#dfdfdf'),
          highlightColor: Utils.colorFromHex('#eeeeee')),
        ],
      ),
    );
  }
}
