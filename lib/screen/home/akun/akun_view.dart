import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/avenir_text.dart';

class AkunView extends StatefulWidget {
  @override
  _AkunScreenState createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextAvenir('AKUN', size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.04),
              Center(
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: Image.asset(ImageConstant.logo),
                      ),
                      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2U_L6KJsOv1ZX5v-JScbk8ZO_ZEe5CwOvmA&usqp=CAU',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
