import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class BiodataSpouse extends StatefulWidget {
  @override
  _BiodataSpouseState createState() => _BiodataSpouseState();
}

class _BiodataSpouseState extends State<BiodataSpouse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextAvenir('Pasangan', size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/tambah_pasangan');
                  },
                  child: Icon(Icons.add, color: Utils.colorFromHex(ColorCode.bluePrimary)))
          )
        ],
      ),
      body: Container(
        color: Utils.colorFromHex(ColorCode.softGreyElsimil),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAvenir('Permintaan Tambah Pasangan', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                    SizedBox(height: 15),
                    itemPasangan()
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAvenir('Pasangan', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                    SizedBox(height: 5),
                    Wrap(
                      children: [
                        Text('Belum terdapat data pasangan.Silahkan tambahkan atau Terima setelah mendapat permintaan "Tambah Pasangan" dari pasangan anda',
                        style: TextStyle(fontSize: 14, color: Utils.colorFromHex(ColorCode.bluePrimary), fontFamily: 'Avenir-Book'))
                      ],
                    )
                    ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  itemPasangan(){
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: ConstantStyle.box_fill_grey,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                TextAvenir('Amanda Manopo', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                TextAvenirBook('Medan, 23 Oktober 2000', size: 13, color: Utils.colorFromHex(ColorCode.bluePrimary)),
              ],
            ),
          ),
          Row(
            children: [
              TextAvenir('Terima', size: 14, color: Utils.colorFromHex(ColorCode.greenElsimil)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: size.height * 0.026, color: Colors.grey, width: 0.5,),
              TextAvenir('Tolak', color: Utils.colorFromHex(ColorCode.redElsimil)),
            ],
          )
        ],
      ),
    );
  }

}
