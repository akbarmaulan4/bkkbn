import 'package:flutter/material.dart';
import 'package:kua/bloc/notif/notif_bloc.dart';
import 'package:kua/model/notif/item_notif.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/font/avenir_book.dart';
import 'package:kua/widgets/font/avenir_text.dart';
import 'package:kua/widgets/pull_refresh_widget.dart';

class ListNotif extends StatefulWidget {
  @override
  _ListNotifState createState() => _ListNotifState();
}

class _ListNotifState extends State<ListNotif> {

  NotifBloc bloc = NotifBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.listNotif();

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    bloc.delete.listen((event) {
      if(event != null){
        if(event){
          Utils.showConfirmDialog(context, 'Informasi', 'Anda berhasil menghapus notifikasi', () {
            bloc.listNotif();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextAvenir('Notifkasi', color: Utils.colorFromHex(ColorCode.bluePrimary)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: ()=>Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios_rounded, color: Utils.colorFromHex(ColorCode.bluePrimary))
        ),
        bottom: PreferredSize(
            child: Container(
              color: Utils.colorFromHex(ColorCode.lightBlueDark),
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(4.0)),
        actions: [
          InkWell(
            onTap: ()=>Utils.dialogMessage(
                context: context,
                title: 'Hapus semua notifikasi?',
                ok: ()=>bloc.deleteNotif(context)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.delete, color: Colors.grey)
            )
          )
        ],
      ),
      body: PullRefreshWidget(
        onRefresh: ()=> bloc.listNotif(),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Utils.colorFromHex(ColorCode.softGreyElsimil),
                  child: StreamBuilder(
                    stream: bloc.dataNotif,
                    builder: (context, snapshot) {
                      List<ItemNotif> data = [];
                      if(snapshot.data != null){
                        data = snapshot.data;
                      }
                      return Container(
                        child: ListView.separated(
                          itemCount: data.length,
                          separatorBuilder: (context, index){
                            return Container(
                              height: 0.5,
                              color: Colors.grey.shade300,
                              width: double.infinity,
                            );
                          },
                          itemBuilder: (context, index){
                            ItemNotif notif = data[index];
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.baseline,
                                // textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 40),
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: new BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextAvenirBook('${notif.title}, ${notif.content}', color: Utils.colorFromHex(ColorCode.bluePrimary), size: 14),
                                          SizedBox(height: 15),
                                          TextAvenirBook(notif.waktu, color: Colors.grey, size: 12,),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        ),
                      );
                    }
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
