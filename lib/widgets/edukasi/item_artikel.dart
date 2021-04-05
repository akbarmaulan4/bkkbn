import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/model/edukasi/artikel_item.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';

import '../font/avenir_book.dart';
import '../font/avenir_text.dart';

class ItemArtikelWidget extends StatefulWidget {
  ArtikelItem item;
  ItemArtikelWidget({this.item});
  @override
  _ItemArtikelWidgetState createState() => _ItemArtikelWidgetState();
}

class _ItemArtikelWidgetState extends State<ItemArtikelWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextAvenir(widget.item.judul, color: Utils.colorFromHex(ColorCode.bluePrimary), size: 16),
              SizedBox(height: 7),
              TextAvenirBook(widget.item.deskripsi, color: Utils.colorFromHex(ColorCode.darkGreyElsimil), size: 14, lines: 3,)
            ],
          )),
          SizedBox(width: 15),
          Container(
            width: size.height * 0.10,
            height: size.height * 0.10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: CachedNetworkImage(
              placeholder: (context, url) => Center(
                child: Image.asset(ImageConstant.placeHolderElsimil),
              ),
              imageUrl: widget.item.image, //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2U_L6KJsOv1ZX5v-JScbk8ZO_ZEe5CwOvmA&usqp=CAU',
              imageBuilder: (context, imageProvider) => Container(
                width: size.height * 0.10,
                height: size.height * 0.10,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover
                  ),
                ),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
