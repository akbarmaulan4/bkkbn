import 'package:flutter/material.dart';
import 'package:kua/bloc/hamil/hamil_controller.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class HamilEntranceScreen extends StatefulWidget {
  @override
  _HamilEntranceScreenState createState() => _HamilEntranceScreenState();
}

class _HamilEntranceScreenState extends State<HamilEntranceScreen> {

  HamilController controller = HamilController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.getStatusHamil();

    controller.hamil.listen((data) {
      if(data){
        Navigator.of(context).pushNamed('/janin_screen');
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
        title: TextAvenir('Hamil', color: Utils.colorFromHex(ColorCode.bluePrimary),),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.13),
            // cardCategory(),
            Image.asset(ImageConstant.placeholder_hamil, height: size.height * 0.16,),
            SizedBox(height: 40),
            InkWell(
              onTap: ()=>dialogHamil(context),
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
                    TextAvenir('Pendampingan Hamil', color: Colors.white, size: 14,)
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

  cardCategory(){
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: ConstantStyle.boxButton(radius: 10, color: Colors.grey.shade200),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: size.height * 0.13,
      width: size.height * 0.13,
      // child: Center(
      //   child: TextAvenir(label),
      // ),
    );
  }

  dialogHamil(BuildContext context){
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
                            controller.updateStatusHamil(context);
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
