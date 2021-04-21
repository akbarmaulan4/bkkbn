import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/local_data.dart';
import 'file:///F:/Kerjaan/Freelance/Hybrid/kua/kua_git/bkkbn/lib/widgets/font/avenir_text.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class RegisterDataDiri extends StatefulWidget {

  AuthBloc bloc;
  RegisterDataDiri({this.bloc});

  @override
  _RegisterDataDiriState createState() => _RegisterDataDiriState();
}

class _RegisterDataDiriState extends State<RegisterDataDiri> {

  List<String> dataGender = [];
  String genderSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setupPlayerId();

    dataGender.add('Laki-laki');
    dataGender.add('Perempuan');

    if(widget.bloc.allProvinsi.length < 1){
      widget.bloc.getProvinsi();
    }

    widget.bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    widget.bloc.allowDataDiri.listen((event) {
      if(event != null){
        if(event){
          Utils.infoDialog(context, 'Informasi', 'Registrasi berhasil, silahkan aktivasi akun kamu melalui email yang kami kirim', () {
            Navigator.popAndPushNamed(context, '/login');
          });
        }
      }
    });

    // widget.bloc.showFinder.listen((event) {
    //   if(event != null){
    //     if(event){
    //       // showFinder(type)
    //     }
    //   }
    // });

  }

  void setupPlayerId() async {
    var hasPlayerId = await LocalData.getPlayerId();
    if (hasPlayerId == null) {
      var status = await OneSignal.shared.getPermissionSubscriptionState();
      var playerId = status.subscriptionStatus.userId;
      widget.bloc.setPlayerId(playerId);
    }
  }

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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAvenir(
                      'Tempat Lahir',
                      size: 14,
                      color: Utils.colorFromHex(ColorCode.bluePrimary),
                    ),
                    SizedBox(height: 5),
                    BoxBorderDefault(
                        child: TextField(
                          controller: widget.bloc.edtTmptLahir,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tempat Lahir',
                              hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                              contentPadding: EdgeInsets.only(bottom:16)
                          )
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAvenir(
                      'Tangal Lahir',
                      size: 14,
                      color: Utils.colorFromHex(ColorCode.bluePrimary),
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: (){
                        widget.bloc.openDatePicker(context);
                      },
                      child: BoxBorderDefault(
                          child: TextField(
                            controller: widget.bloc.edtTglLahir,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Tanggal Lahir',
                                hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                contentPadding: EdgeInsets.only(bottom:16)
                            ),
                            enabled: false,
                          )
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAvenir(
                      'Jenis Kelamin',
                      size: 14,
                      color: Utils.colorFromHex(ColorCode.bluePrimary),
                    ),
                    SizedBox(height: 5),
                    StreamBuilder(
                      stream: widget.bloc.jenisKelamin,
                      builder: (context, snapshot) {
                        String data = widget.bloc.strGender;
                        if(snapshot.data != null){
                          data = snapshot.data;
                        }
                        return BoxBorderDefault(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: TextAvenir(
                                  'Jenis Kelamin',
                                  size: 12,
                                ),
                                value: data,
                                items: dataGender.map((value) {
                                  return DropdownMenuItem(
                                    child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(value)),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // widget.bloc.changeGender(value);
                                  widget.bloc.pilihJenisKelamin(value);
                                  // setState(() {
                                  //   genderSelected = value;
                                  // });
                                  // widget.bloc.pilihJenisKelamin(value);
                                },
                              )
                            )
                        );
                      }
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: SizedBox(),
              )
            ],
          ),
          SizedBox(height: 15),
          TextAvenir(
            'Alamat Sesuai KTP',
            size: 14,
            color: Utils.colorFromHex(ColorCode.bluePrimary),
          ),
          SizedBox(height: 5),
          BoxBorderDefault(
              child: TextField(
                controller: widget.bloc.edtAlamatKtp,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Alamat Sesuai KTP',
                    hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                    contentPadding: EdgeInsets.only(bottom:16)
                ),
              )
          ),
          SizedBox(height: 15),
          TextAvenir(
            'Provinsi',
            size: 14,
            color: Utils.colorFromHex(ColorCode.bluePrimary),
          ),
          SizedBox(height: 5),
          // StreamBuilder(
          //   stream: widget.bloc.downloadProvinsi,
          //   builder: (context, snapshot) {
          //     var load = false;
          //     if(snapshot.data != null){
          //       load = snapshot.data;
          //     }
          //     return BoxBorderDefault(
          //       child: Row(
          //         children: [
          //           Expanded(
          //             child: TypeAheadField(
          //               noItemsFoundBuilder: (context){
          //                 return SizedBox();
          //               },
          //               textFieldConfiguration: TextFieldConfiguration(
          //                 controller: widget.bloc.edtProvinsi,
          //                 decoration: InputDecoration(border: InputBorder.none),
          //               ),
          //               suggestionsCallback: (pattern) async {
          //                 return await widget.bloc.findProvinsi(pattern);
          //               },
          //               itemBuilder: (context, suggestion) {
          //                 DataProvinsi prov = suggestion;
          //                 return ListTile(
          //                   leading: Icon(Icons.location_city_rounded),
          //                   title: Text(prov.nama),
          //                 );
          //               },
          //               onSuggestionSelected: (suggestion) {
          //                 widget.bloc.changeProvinsi(suggestion);
          //               },
          //             ),
          //           ),
          //           load ? Container(
          //             height: 20,
          //             width: 20,
          //             child: CircularProgressIndicator()
          //           ):SizedBox(),
          //           SizedBox(width: load ? 10 : 0)
          //         ],
          //       )
          //     );
          //   }
          // ),
          BoxBorderDefault(
            child: InkWell(
              onTap: ()=>showFinder('provinsi'),
              child: TextField(
                controller: widget.bloc.edtProvinsi,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Provinsi',
                    hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                    contentPadding: EdgeInsets.only(bottom:16)
                ),
                enabled: false,
              ),
            ),
          ),
          SizedBox(height: 15),
          TextAvenir(
            'Kabupaten/Kota',
            size: 14,
            color: Utils.colorFromHex(ColorCode.bluePrimary),
          ),
          SizedBox(height: 5),
          StreamBuilder(
            stream: widget.bloc.downloadKab,
            builder: (context, snapshot) {
              var load = false;
              if(snapshot.data != null){
                load = snapshot.data;
              }
              return BoxBorderDefault(
                  child: InkWell(
                    onTap: ()=>showFinder('kota'),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: widget.bloc.edtKotaKab,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Kabupaten/Kota',
                                hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                contentPadding: EdgeInsets.only(bottom:16)
                            ),
                            enabled: false,
                          ),
                          // child: TypeAheadField(
                          //   noItemsFoundBuilder: (context){
                          //     return SizedBox();
                          //   },
                          //   textFieldConfiguration: TextFieldConfiguration(
                          //     controller: widget.bloc.edtKotaKab,
                          //     decoration: InputDecoration(border: InputBorder.none),
                          //   ),
                          //   suggestionsCallback: (pattern) async {
                          //     return await widget.bloc.findKabupaten(pattern);
                          //   },
                          //   itemBuilder: (context, suggestion) {
                          //     DataKabupaten kab = suggestion;
                          //     return ListTile(
                          //       leading: Icon(Icons.location_city_rounded),
                          //       title: Text(kab.nama),
                          //     );
                          //   },
                          //   onSuggestionSelected: (suggestion) {
                          //     widget.bloc.changeKabupaten(suggestion);
                          //   },
                          // ),
                        ),
                        load ? Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()
                        ):SizedBox(),
                        SizedBox(width: load ? 10 : 0)
                      ],
                    ),
                  )
              );
            }
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAvenir(
                      'Kecamatan',
                      size: 14,
                      color: Utils.colorFromHex(ColorCode.bluePrimary),
                    ),
                    SizedBox(height: 5),
                    StreamBuilder(
                      stream: widget.bloc.downloadKec,
                      builder: (context, snapshot) {
                        var load = false;
                        if(snapshot.data != null){
                          load = snapshot.data;
                        }
                        return BoxBorderDefault(
                            child: InkWell(
                              onTap: ()=>showFinder('kecamatan'),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: widget.bloc.edtKecamatan,
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Kecamatan',
                                          hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                          contentPadding: EdgeInsets.only(bottom:16)
                                      ),
                                      enabled: false,
                                    ),
                                    // child: TypeAheadField(
                                    //   noItemsFoundBuilder: (context){
                                    //     return SizedBox();
                                    //   },
                                    //   textFieldConfiguration: TextFieldConfiguration(
                                    //     controller: widget.bloc.edtKecamatan,
                                    //     decoration: InputDecoration(border: InputBorder.none),
                                    //   ),
                                    //   suggestionsCallback: (pattern) async {
                                    //     return await widget.bloc.findKecamatan(pattern);
                                    //   },
                                    //   itemBuilder: (context, suggestion) {
                                    //     DataKecamatan kec = suggestion;
                                    //     return ListTile(
                                    //       leading: Icon(Icons.location_city_rounded),
                                    //       title: Text(kec.nama),
                                    //     );
                                    //   },
                                    //   onSuggestionSelected: (suggestion) {
                                    //     widget.bloc.changeKecamatan(suggestion);
                                    //   },
                                    // ),
                                  ),
                                  load ? Container(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator()
                                  ):SizedBox(),
                                  SizedBox(width: load ? 10 : 0)
                                ],
                              ),
                            )
                        );
                      }
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAvenir(
                      'Kel/Desa',
                      size: 14,
                      color: Utils.colorFromHex(ColorCode.bluePrimary),
                    ),
                    SizedBox(height: 5),
                    StreamBuilder(
                      stream: widget.bloc.downloadKel,
                      builder: (context, snapshot) {
                        var load = false;
                        if(snapshot.data != null){
                          load = snapshot.data;
                        }
                        return BoxBorderDefault(
                            child: InkWell(
                              onTap: ()=>showFinder('kelurahan'),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: widget.bloc.edtDesa,
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Kelurahan',
                                          hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                          contentPadding: EdgeInsets.only(bottom:16)
                                      ),
                                      enabled: false,
                                    ),
                                    // child: TypeAheadField(
                                    //   noItemsFoundBuilder: (context){
                                    //     return SizedBox();
                                    //   },
                                    //   textFieldConfiguration: TextFieldConfiguration(
                                    //     controller: widget.bloc.edtDesa,
                                    //     decoration: InputDecoration(border: InputBorder.none),
                                    //   ),
                                    //   suggestionsCallback: (pattern) async {
                                    //     return await widget.bloc.findKelurahan(pattern);
                                    //   },
                                    //   itemBuilder: (context, suggestion) {
                                    //     DataKelurahan kel = suggestion;
                                    //     return ListTile(
                                    //       leading: Icon(Icons.location_city_rounded),
                                    //       title: Text(kel.nama),
                                    //     );
                                    //   },
                                    //   onSuggestionSelected: (suggestion) {
                                    //     widget.bloc.changeKelurahan(suggestion);
                                    //   },
                                    // ),
                                  ),
                                  load ? Container(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator()
                                  ):SizedBox(),
                                  SizedBox(width: load ? 10 : 0)
                                ],
                              ),
                            )
                        );
                      }
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextAvenir(
                            'RT',
                            size: 14,
                            color: Utils.colorFromHex(ColorCode.bluePrimary),
                          ),
                          SizedBox(height: 5),
                          BoxBorderDefault(
                              child: TextField(
                                controller: widget.bloc.edtRT,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'RT',
                                    hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                    contentPadding: EdgeInsets.only(bottom:16)
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                  new BlacklistingTextInputFormatter(
                                      new RegExp('[\\-|\\,|\\.]')),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextAvenir(
                            'RW',
                            size: 14,
                            color: Utils.colorFromHex(ColorCode.bluePrimary),
                          ),
                          SizedBox(height: 5),
                          BoxBorderDefault(
                              child: TextField(
                                controller: widget.bloc.edtRW,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'RW',
                                    hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                    contentPadding: EdgeInsets.only(bottom:16)
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                  new BlacklistingTextInputFormatter(
                                      new RegExp('[\\-|\\,|\\.]')),
                                ],
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextAvenir(
                      'Kode POS',
                      size: 14,
                      color: Utils.colorFromHex(ColorCode.bluePrimary),
                    ),
                    SizedBox(height: 5),
                    BoxBorderDefault(
                        child: TextField(
                          controller: widget.bloc.edtKodePos,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Kode POS',
                              hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                              contentPadding: EdgeInsets.only(bottom:16)
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                            new BlacklistingTextInputFormatter(
                                new RegExp('[\\-|\\,|\\.]')),
                          ],
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: size.height * 0.04),
          InkWell(
            onTap: (){
              widget.bloc.validasiDataDiri(context);
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Utils.colorFromHex(ColorCode.blueSecondary),
                boxShadow: [
                  BoxShadow(
                    color: Utils.colorFromHex(ColorCode.lightGreyElsimil),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0,0),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Center(
                child: TextAvenir(
                  'Lanjutkan',
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: is5Inc() ? 40:0)
        ],
      ),
    );
  }

  getStreamFinder(String type){
    switch(type){
      case 'provinsi':
        return widget.bloc.dataProvinsi;
      case 'kota':
        return widget.bloc.dataKotaKab;
      case 'kecamatan':
        return widget.bloc.dataKecamatan;
      case 'kelurahan':
        return widget.bloc.dataKelurahan;
    }
  }

  getDataFinder(String type){
    switch(type){
      case 'provinsi':
        return widget.bloc.allDataProvinsi;
      case 'kota':
        return widget.bloc.allDataKabupaten;
      case 'kecamatan':
        return widget.bloc.allDataKecamatan;
      case 'kelurahan':
        return widget.bloc.allDataKelurahan;
    }
  }

  finding(String type, String param){
    switch(type){
      case 'provinsi':
        widget.bloc.findProvinsi(param);
        break;
      case 'kota':
        widget.bloc.findKabupaten(param);
        break;
      case 'kecamatan':
        widget.bloc.findKecamatan(param);
        break;
      case 'kelurahan':
        widget.bloc.findKelurahan(param);
        break;
    }
  }

  loadFindingFirst(String type, String param){
    switch(type){
      case 'provinsi':
        widget.bloc.findProvinsi(param);
        break;
      case 'kota':
        widget.bloc.findKabupaten(param);
        break;
      case 'kecamatan':
        widget.bloc.findKecamatan(param);
        break;
      case 'kelurahan':
        widget.bloc.findKelurahan(param);
        break;
    }
  }

  setFindingValue(String type, dynamic data){
    switch(type){
      case 'provinsi':
        widget.bloc.changeProvinsi(data);
        break;
      case 'kota':
        widget.bloc.changeKabupaten(data);
        break;
      case 'kecamatan':
        widget.bloc.changeKecamatan(data);
        break;
      case 'kelurahan':
        widget.bloc.changeKelurahan(data);
        break;
    }
  }

  void showFinder(String type) async {
    var size = MediaQuery.of(context).size;
    loadFindingFirst(type, 'a');
    var dataSink = getDataFinder(type);
    var stream = getStreamFinder(type);
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        // backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
                return Container(
                  height: size.height * 0.50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey[300])
                        ),
                        padding: EdgeInsets.only(right: 25),
                        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        height: 45,
                        child: TextField(
                          // controller: bloc.edtUsername,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cari ${type}...',
                            fillColor: Colors.grey,
                            prefixIcon: Icon(Icons.search, size: 20),
                            contentPadding: EdgeInsets.only(bottom: 7)
                          ),
                          onChanged: (val){
                            finding(type, val);
                          },
                        ),
                      ),
                      StreamBuilder(
                        stream: stream,
                        builder: (context, snapshot) {
                          List<dynamic> data = dataSink;
                          if(snapshot.data != null){
                            data = snapshot.data;
                          }
                          return Expanded(
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    setFindingValue(type, data[index]);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Text(data[index].nama),
                                          // ListTile(
                                          //   title: Text(data[index].nama),
                                          //   leading: Icon(CupertinoIcons.check_mark_circled_solid),
                                          //   contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                          // ),
                                          Row(
                                            // crossAxisAlignment: CrossAxisAlignment.baseline,
                                            // textBaseline: TextBaseline.ideographic,
                                            children: [
                                              Icon(CupertinoIcons.check_mark_circled_solid),
                                              SizedBox(width: 10),
                                              Text(data[index].nama),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Container(height: 0.5, width: double.infinity, color: Colors.grey[200],)
                                        ],
                                      )
                                  ),
                                );
                              }
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
