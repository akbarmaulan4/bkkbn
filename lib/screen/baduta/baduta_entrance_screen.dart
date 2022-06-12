import 'package:flutter/material.dart';
import 'package:kua/bloc/baduta/baduta_controller.dart';
import 'package:kua/bloc/hamil/hamil_controller.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class BadutaEntranceScreen extends StatefulWidget {
  @override
  _BadutaEntranceScreenState createState() => _BadutaEntranceScreenState();
}

class _BadutaEntranceScreenState extends State<BadutaEntranceScreen> {

  // HamilController controller = HamilController();
  BadutaController controller = BadutaController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.baduta.listen((data) {
      if(data){
        Navigator.of(context).pushNamed('/riwayat_baduta_screen');
      }
    });

    controller.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () {
          Navigator.of(context).pop();
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Utils.colorFromHex(ColorCode.colorWhite),
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.chevron_left_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary), size: 30,)),
        title: TextAvenir('Baduta', color: Utils.colorFromHex(ColorCode.bluePrimary),),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.13),
            Image.asset(ImageConstant.placeholder_baduta, height: size.height * 0.16,),
            SizedBox(height: 40),
            InkWell(
              onTap: ()=>dialogBaduta(context),
              child: Container(
                width: size.width * 0.55,
                decoration: ConstantStyle.boxShadowButon(
                    radius: 30, color: Utils.colorFromHex(ColorCode.blueSecondary),
                    colorShadow: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3, blurRadius: 5, offset: Offset(1,3)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    TextAvenir('Saya Ingin Mengikuti', color: Colors.white, size: 14),
                    TextAvenir('Pendampingan Baduta', color: Colors.white, size: 14,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // TextAvenir('Pendampingan Hamil')
          ],
        ),
      ),
    );
  }

  dialogBaduta(BuildContext context){
    // FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            content: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Column(
                  children: [
                    TextAvenir('Saya ingin di dampingi', size: 15,),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                            // Navigator.of(context).pushNamed('/riwayat_baduta_screen');
                            controller.updateStatusBaduta(context);
                          },
                          child: Container(
                            decoration: ConstantStyle.boxButton(radius: 20, color: Utils.colorFromHex(ColorCode.blueSecondary)),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            width: 100,
                            child: Center(
                              child: TextAvenir('Ya', color: Colors.white, size: 14,),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: ()=>Navigator.pop(context),
                          child: Container(
                            decoration: ConstantStyle.boxButton(radius: 20, color: Utils.colorFromHex(ColorCode.blueSecondary)),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            width: 100,
                            child: Center(
                              child: TextAvenir('Tidak', color: Colors.white, size: 14),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        }
    );
  }
}
