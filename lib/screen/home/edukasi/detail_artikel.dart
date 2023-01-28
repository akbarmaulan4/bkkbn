import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kua/bloc/berita/edukasi_bloc.dart';
import 'package:kua/model/edukasi/artikel_item.dart';
import 'package:kua/model/edukasi/detail_edukasi.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/edukasi/item_artikel.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class DetailArtikel extends StatefulWidget {
  // ArtikelItem data;
  String? id;
  DetailArtikel({this.id});

  @override
  _DetailArtikelState createState() => _DetailArtikelState();
}

class _DetailArtikelState extends State<DetailArtikel> {

  EdukasiBloc bloc = EdukasiBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bloc.getDetailArtikel(context, widget.id!);
      bloc.getRelatedlArtikel();
    });

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.detailEdukasi,
        builder: (context, snapshot) {
          DetailEdukasi detail = DetailEdukasi();
          if(snapshot.data != null){
            detail = snapshot.data as DetailEdukasi;
          }
          return detail.id != null ?  Container(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: size.height * 0.35,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Center(
                            child: Image.asset(ImageConstant.placeHolderElsimil),
                          ),
                          imageUrl: detail.image!,
                          errorWidget: (context, url, error)=>Image.asset(ImageConstant.placeHolderElsimil),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            TextAvenir(detail.kategori!, size: 14, color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                            SizedBox(height: 10),
                            TextAvenir(detail.judul!, size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                            SizedBox(height: 7),
                            TextAvenirBook(detail.tgl_publish!, color: Utils.colorFromHex(ColorCode.darkGreyElsimil), size: 12,),
                            SizedBox(height: 10),
                            Html(
                              data: detail.content != null ? detail.content : '',
    //                           data: """
    // <h1>Table support:</h1>
    // <table>
    // <colgroup>
    // <col width="50%" />
    // <col span="2" width="25%" />
    // </colgroup>
    // <thead>
    // <tr><th>One</th><th>Two</th><th>Three</th></tr>
    // </thead>
    // <tbody>
    // <tr>
    // <td rowspan='2'>Rowspan\nRowspan\nRowspan\nRowspan\nRowspan\nRowspan\nRowspan\nRowspan\nRowspan\nRowspan</td><td>Data</td><td>Data</td>
    // </tr>
    // <tr>
    // <td colspan="2"><img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /></td>
    // </tr>
    // </tbody>
    // <tfoot>
    // <tr><td>fData</td><td>fData</td><td>fData</td></tr>
    // </tfoot>
    // </table>""",
    //                             style: {
    //                               // tables will have the below background color
    //                               "table": Style(
    //                                 backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
    //                               ),
    //                               // some other granular customizations are also possible
    //                               "tr": Style(
    //                                 border: Border(bottom: BorderSide(color: Colors.grey)),
    //                               ),
    //                               "th": Style(
    //                                 padding: EdgeInsets.all(6),
    //                                 backgroundColor: Colors.grey,
    //                               ),
    //                               "td": Style(
    //                                 padding: EdgeInsets.all(6),
    //                                 alignment: Alignment.topLeft,
    //                               ),
    //                               // text that renders h1 elements will be red
    //                               "h1": Style(color: Colors.red),
    //                             }
//                               defaultTextStyle: TextStyle(height: 1.5, fontSize: 14, fontFamily: 'Avenir-Book', color: Utils.colorFromHex(ColorCode.darkGreyElsimil)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            TextAvenir('Edukasi Lainnya', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                            SizedBox(height: 15),
                            StreamBuilder(
                                stream: bloc.allArtikel,
                                builder: (context, snapshot) {
                                  List<ArtikelItem> data = bloc.allRelatedArticle;
                                  if(snapshot.data != null){
                                    data = snapshot.data as List<ArtikelItem>;
                                  }
                                  return data.isNotEmpty ? Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: loadItemRelated(data),
                                    ),
                                  ):SizedBox();
                                }
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.17,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    gradient: new LinearGradient(
                      end: const Alignment(0.0, 0.4),
                      begin: const Alignment(0.0, -1),
                      colors: <Color>[
                        const Color(0x8A000000),
                        Colors.black12.withOpacity(0.0)
                      ],
                    ),

                  ),
                  child: InkWell(
                      onTap: ()=>Navigator.of(context).pop(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                      )),
                )
              ],
            ),
          ):SizedBox();
        }
      ),
    );
  }
  
  loadItemRelated(List<ArtikelItem> items){
    List<Widget> data = [];
    for(ArtikelItem item in items){
      data.add(InkWell(
        onTap: (){
          // bloc.getDetailArtikel(item.id.toString());
          // bloc.getRelatedlArtikel();
          Navigator.popAndPushNamed(context, '/detail_artikel', arguments: {'id': item.id.toString()});
        },
        child: Column(
          children: [
            ItemArtikelWidget(
              item: item,
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
          ],
        ),
      ));
    }
    return data;
  }
}
