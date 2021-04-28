import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/model/home/own.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';

import '../font/avenir_book.dart';
import '../font/avenir_text.dart';

class ItemInfoProfile extends StatefulWidget {
  Own dataOwn;
  List<Own> dataCouple;
  ItemInfoProfile({this.dataOwn, this.dataCouple});
  @override
  _ItemInfoProfileState createState() => _ItemInfoProfileState();
}

class _ItemInfoProfileState extends State<ItemInfoProfile> {

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
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: is5Inc() ? 18:20),
          TextAvenir('Hi, Selamat datang', size: is5Inc() ? 14:16, color: Utils.colorFromHex(ColorCode.lightBlueDark)),
          SizedBox(height: 3),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: Utils.colorFromHex(ColorCode.blueSecondary)
            ),
            padding: EdgeInsets.all(is5Inc() ? 5:10),
            child: Row(
              children: [
                Container(
                  height: is5Inc() ? 35:45,
                  width: is5Inc() ? 35:45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: Image.asset(ImageConstant.logoElsimil),
                      ),
                      imageUrl: (widget.dataOwn != null && widget.dataOwn.pic != null) ? widget.dataOwn.pic:'',//'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2U_L6KJsOv1ZX5v-JScbk8ZO_ZEe5CwOvmA&usqp=CAU',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextAvenir(widget.dataOwn != null ? widget.dataOwn.name:'', size: is5Inc() ? 10 : 12, color: Utils.colorFromHex(ColorCode.lightBlueDark)),
                      TextAvenirBook(widget.dataOwn != null ? '${widget.dataOwn.kota}, ${widget.dataOwn.tgl_lahir}' : '', size: is5Inc() ? 9 : 11, color: Utils.colorFromHex(ColorCode.lightBlueDark)),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          TextAvenir('Pasangan Kamu', size: is5Inc() ? 12:14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
          SizedBox(height: 5),
          widget.dataCouple.isNotEmpty ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: Utils.colorFromHex(ColorCode.lightBlueDark)
            ),
            child: Container(
              height: size.height * 0.08,
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.dataCouple.length,
                  itemBuilder: (context, index){
                    Own data = widget.dataCouple[index];
                    return InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/riwayat_pasangan', arguments: {'id': data.id.toString()});
                      },
                      child: Container(
                        padding: EdgeInsets.all(is5Inc() ? 5:10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.ideographic,
                          children: [
                            Container(
                              height: is5Inc() ? 35:45,
                              width: is5Inc() ? 35:45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Center(
                                    child: Image.asset(ImageConstant.logoElsimil),
                                  ),
                                  imageUrl: data.pic,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextAvenir(data.name, size: is5Inc() ? 10:12, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                                  TextAvenirBook('${data.kota}, ${data.tgl_lahir}', size: is5Inc() ? 9:11, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          ):
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/tambah_pasangan');
            },
            child: Container(
              height: size.height * 0.085,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: Utils.colorFromHex(ColorCode.lightBlueDark)
              ),
              padding: EdgeInsets.all(is5Inc() ? 5: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  //blm ada pasangan
                  // Icon(Icons.supervised_user_circle, color: Colors.grey, size: 40,),
                  Container(
                    height: is5Inc() ? 35:50,
                    width: is5Inc() ? 35:50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(ImageConstant.icAccount),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        TextAvenir('Tambahkan Pasanganmu', size: is5Inc() ? 11:13, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                        // TextAvenir('Amanda Manopo', size: 13),
                        // TextAvenirBook('Medan, 23 Oktober 2000', size: 11),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
