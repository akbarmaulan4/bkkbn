import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kua/bloc/akun/akun_bloc.dart';
import 'package:kua/model/akun/biodata/all_waiting.dart';
import 'package:kua/model/akun/biodata/couple_item.dart';
import 'package:kua/model/akun/biodata/pending_item.dart';
import 'package:kua/model/akun/biodata/waiting_item.dart';
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

  AkunBloc bloc = AkunBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadData(context);
    });

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    bloc.confirmCouple.listen((event) {
      if(event != null){
        if(event){
          Utils.showConfirmDialog(context, 'Informasi', 'Anda berhasil konfirmasi', () {
            loadData(context);
          });
        }
      }
    });
  }

  is5Inc(){
    var size = MediaQuery.of(context).size;
    if(size.height < 630){
      return true;
    }else{
      return false;
    }
  }

  loadData(BuildContext context){
    bloc.listSpouse(context);
  }

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
          StreamBuilder(
            stream: bloc.canAddCouple,
            builder: (context, snapshot) {
              var canAdd = false;
              if(snapshot.data != null){
                canAdd = snapshot.data;
              }
              return canAdd ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/tambah_pasangan').then((value) => loadData(context));
                      },
                      child: Icon(Icons.add, color: Utils.colorFromHex(ColorCode.bluePrimary)))
              ):SizedBox();
            }
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
              //jika ada list pasangan pending/menunggu confirmasi
              StreamBuilder(
                stream: bloc.dataCouple,
                builder: (context, snapshot) {
                  List<CoupleItem> data = [];
                  if(snapshot.data != null){
                    data = snapshot.data;
                  }
                  return data.isNotEmpty ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextAvenir('Pasangan Anda', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                        SizedBox(height: 15),
                        Column(
                          children: loadCouple(data),
                        ),
                      ],
                    ),
                  ):SizedBox();
                }
              ),
              StreamBuilder(
                stream: bloc.waitingCouple,
                builder: (context, snapshot) {
                  AllWaiting data;
                  if(snapshot.data != null){
                    data = snapshot.data;
                  }
                  return data != null ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: (data.pending.isNotEmpty && data.pending.isNotEmpty) ?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextAvenir('Permintaan Tambah Pasangan', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                        SizedBox(height: 15),
                        Column(
                          children: loadWaitingCouple(data != null ? data.waiting : []),
                        ),
                        Column(
                          children: loadPendingCouple(data != null ? data.pending : []),
                        ),
                      ],
                    ):SizedBox(),
                  ):SizedBox();
                }
              ),
              StreamBuilder(
                stream: bloc.showInfoCouple,
                builder: (context, snapshot) {
                  bool show = false;
                  if(snapshot.data != null){
                    show = snapshot.data;
                  }
                  return show ? Column(
                    children: [
                      StreamBuilder(
                        stream: bloc.dataCouple,
                        builder: (context, snapshot) {
                          List<CoupleItem> data = [];
                          if(snapshot.data != null){
                            data = snapshot.data;
                          }
                          return data.isNotEmpty ? Divider():SizedBox();
                        }
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                      ),
                    ],
                  ):SizedBox();
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  loadCouple(List<CoupleItem> data){
    List<Widget> dataWidget = [];
    for(CoupleItem item in data){
      dataWidget.add(itemPasangan(item));
    }
    return dataWidget;
  }

  loadWaitingCouple(List<WaitingItem> data){
    List<Widget> dataWidget = [];
    for(WaitingItem item in data){
      dataWidget.add(itemMenungguConfirmasi(item));
    }
    return dataWidget;
  }

  loadPendingCouple(List<PendingItem> data){
    List<Widget> dataWidget = [];
    for(PendingItem item in data){
      dataWidget.add(itemConfirmPasangan(item));
    }
    return dataWidget;
  }

  itemMenungguConfirmasi(WaitingItem data){
    return Container(
      decoration: BoxDecoration(
        color: Utils.colorFromHex(ColorCode.lightBlueDark),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
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
                  child: Image.asset(ImageConstant.logoElsimil),
                ),
                imageUrl: data != null ? data.pic : '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextAvenir(data != null ? data.name : '', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                TextAvenirBook(data != null ? '${data.kota}, ${data.tgl_lahir}':'', size: 13, color: Utils.colorFromHex(ColorCode.bluePrimary)),
              ],
            ),
          ),
          TextAvenir('Menunggu Konfirmasi', size: 14, color: Utils.colorFromHex(ColorCode.lightGreyElsimil)),
        ],
      ),
    );
  }

  itemConfirmPasangan(PendingItem data){
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
                  child: Image.asset(ImageConstant.logoElsimil),
                ),
                imageUrl: data != null ? data.pic : '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextAvenir(data != null ? data.name : '', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                TextAvenirBook(data != null ? '${data.kota}, ${data.tgl_lahir}':'', size: 13, color: Utils.colorFromHex(ColorCode.bluePrimary)),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: (){
                  Utils.showConfirmDialog(context, 'Peringatan', 'Apakah anda ingin menerima ${data != null ? data.name : ''}', () {
                    bloc.confirmSpouse(context, data.request_id.toString(), 'terima');
                  });
                },
                child: TextAvenir('Terima', size: 14, color: Utils.colorFromHex(ColorCode.greenElsimil))
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: size.height * 0.026, color: Colors.grey, width: 0.5,),
              InkWell(
                onTap: (){
                  Utils.showConfirmDialog(context, 'Peringatan', 'Apakah anda ingin menolak ${data != null ? data.name : ''}', () {
                    bloc.confirmSpouse(context, data.request_id.toString(), 'tolak');
                  });
                },
                child: TextAvenir('Tolak', color: Utils.colorFromHex(ColorCode.redElsimil))
              ),
            ],
          )
        ],
      ),
    );
  }

  itemPasangan(CoupleItem data){
    return InkWell(
      onTap: ()=>  Navigator.pushNamed(context, '/riwayat_pasangan', arguments: {'id': data.id.toString()}),
      child: Container(
        decoration: ConstantStyle.box_fill_blue_nd,
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
                    child: Image.asset(ImageConstant.placeHolderAccount),
                  ),
                  imageUrl: data != null ? data.pic : '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAvenir(data != null ? data.name : '', size: 14, color: Colors.white),
                  TextAvenirBook(data != null ? '${data.kota}, ${data.tgl_lahir}':'', size: 13, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
