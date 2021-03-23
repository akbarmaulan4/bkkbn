import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';

import '../font/avenir_book.dart';
import '../font/avenir_text.dart';

class ItemInfoProfile extends StatefulWidget {
  @override
  _ItemInfoProfileState createState() => _ItemInfoProfileState();
}

class _ItemInfoProfileState extends State<ItemInfoProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          TextAvenir('Hi, Selamat datang', size: 16, color: Colors.white,),
          SizedBox(height: 3),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: Utils.colorFromHex(ColorCode.blueSecondary)
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
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
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextAvenir('Amanda Manopo', size: 13, color: Colors.white,),
                      TextAvenirBook('Medan, 23 Oktober 2000', size: 11, color: Colors.white,),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          TextAvenir('Pasangan Kamu', size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: Colors.white
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 23),
            child: Row(
              children: [
                // Container(
                //   height: 50,
                //   width: 50,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //   ),
                //   child: ClipOval(
                //     child: CachedNetworkImage(
                //       placeholder: (context, url) => Center(
                //         child: Image.asset(ImageConstant.logo),
                //       ),
                //       imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2U_L6KJsOv1ZX5v-JScbk8ZO_ZEe5CwOvmA&usqp=CAU',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                //blm ada pasangan
                Container(
                  height: 20,
                  width: 20,
                  child: Icon(Icons.supervised_user_circle, color: Colors.grey,),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextAvenir('Tambahkan Pasanganmu', size: 10, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                      // TextAvenir('Amanda Manopo', size: 13),
                      // TextAvenirBook('Medan, 23 Oktober 2000', size: 11),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
