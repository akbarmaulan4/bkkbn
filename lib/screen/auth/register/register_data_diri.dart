import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/model/model_location.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/debouncher.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/util/local_data.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../widgets/font/avenir_text.dart';

class RegisterDataDiri extends StatefulWidget {

  AuthBloc bloc;
  RegisterDataDiri({this.bloc});

  @override
  _RegisterDataDiriState createState() => _RegisterDataDiriState();
}

class _RegisterDataDiriState extends State<RegisterDataDiri> {

  List<String> dataGender = [];
  String genderSelected;
  var debouncher = new Debouncer(milliseconds: 500);

  File _image;
  final picker = ImagePicker();

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 100, maxWidth: 1024, maxHeight: 768);
    setState(() {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        widget.bloc.changeImage(image);
        setState(() {
          _image = image;
        });
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 100, maxWidth: 1024, maxHeight: 768);
    setState(() {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        widget.bloc.changeImage(image);
        setState(() {
          _image = image;
        });
      } else {
        print('No image selected.');
      }
    });
  }

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
        Utils.infoDialog(context, 'Informasi', event, () {
          Navigator.popAndPushNamed(context, '/login');
        });
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

  List<String> dataNikah = ['Sudah Menikah', 'Belum Menikah'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: scaleFactor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
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
                              inputFormatters: [
                                WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                              ],
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
                        TextAvenir('Jenis Kelamin', size: 14, color: Utils.colorFromHex(ColorCode.bluePrimary)),
                        SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          child: StreamBuilder(
                            stream: widget.bloc.jenisKelamin,
                            builder: (context, snapshot) {
                              String data = widget.bloc.strGender;
                              if(snapshot.data != null){
                                data = snapshot.data;
                              }
                              return BoxBorderDefault(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: TextAvenir('Jenis Kelamin', size: 12),
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
                                        widget.bloc.pilihJenisKelamin(value);
                                      },
                                    )
                                  )
                              );
                            }
                          ),
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
                          'Status Pernikahan',
                          size: 14,
                          color: Utils.colorFromHex(ColorCode.bluePrimary),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          child: StreamBuilder(
                              stream: widget.bloc.dataStatusNikah,
                              builder: (context, snapshot) {
                                String data = widget.bloc.strStatusNikah;
                                if (snapshot.data != null) {
                                  data = snapshot.data;
                                }
                                return BoxBorderDefault(
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: TextAvenir(
                                            'Status Pernikahan',
                                            size: 12,
                                          ),
                                          value: data,
                                          items: dataNikah.map((value) {
                                            return DropdownMenuItem(
                                              child: Container(
                                                  margin:
                                                  EdgeInsets.symmetric(horizontal: 10),
                                                  child: Text(value)),
                                              value: value,
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            widget.bloc.statusNikah(value);
                                          },
                                        )));
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              TextAvenir(
                'No KTP',
                size: 14,
                color: Utils.colorFromHex(ColorCode.bluePrimary),
              ),
              SizedBox(height: 5),
              BoxBorderDefault(
                  child: TextField(
                    controller: widget.bloc.edtKtp,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(16),
                      WhitelistingTextInputFormatter(RegExp("[0-9]")),
                    ],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukan 16 digit No KTP anda',
                        hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                        contentPadding: EdgeInsets.only(bottom:16)
                    ),
                    onChanged: (val){
                      if(val.length > 15){
                        debouncher.run(() {
                          widget.bloc.checkNIK();
                        });
                      }
                    },//ConstantStyle.decorTextField,
                  )
              ),
              SizedBox(height: 25),
              StreamBuilder(
                stream: widget.bloc.imageKtp,
                builder: (context, snapshot) {
                  File img;
                  if(snapshot.data != null){
                    img = snapshot.data;
                  }
                  return img != null ? Container(
                    child: Image.file(
                      img,
                      width: size.width * 0.88,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ) : DottedBorder(
                    color: Utils.colorFromHex(ColorCode.lightBlueDark),
                    strokeWidth: 1,
                    child: Container(
                      child: InkWell(
                        onTap: (){
                          showPicker();
                        },
                        child: StreamBuilder(
                            stream: widget.bloc.fileDoc,
                            builder: (context, snapshot) {
                              File exist;
                              String fileName = 'Foto KTP';
                              if(snapshot.data != null){
                                exist = snapshot.data;
                                fileName = exist.path.split('/').last;
                              }
                              return Row(
                                children: [
                                  Image.asset(exist != null ? ImageConstant.icPdf : ImageConstant.noImages, height: size.height * 0.10,),
                                  SizedBox(width: 10),
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextAvenir(
                                        fileName,
                                        size: 14,
                                        color: Utils.colorFromHex(ColorCode.bluePrimary),
                                      ),
                                      SizedBox(height: 8),
                                      TextAvenir(
                                        'File yang didukung: jpeg/png',
                                        size: 12,
                                        color: Colors.grey[400],
                                      ),
                                    ],
                                  ))
                                ],
                              );
                            }
                        ),
                      ),
                    ),
                  );
                }
              ),
              SizedBox(height: 15),
              TextAvenir(
                'Alamat Sesuai Domisili',
                size: 14,
                color: Utils.colorFromHex(ColorCode.bluePrimary),
              ),
              SizedBox(height: 5),
              BoxBorderDefault(
                  child: TextField(
                    controller: widget.bloc.edtAlamatKtp,
                    textAlignVertical: TextAlignVertical.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(150)
                    ],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Alamat Sesuai Domisili',
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
                                      WhitelistingTextInputFormatter(RegExp("[0-9]")),
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
                                      WhitelistingTextInputFormatter(RegExp("[0-9]")),
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
                                WhitelistingTextInputFormatter(RegExp("[0-9]")),
                              ],
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              TextAvenir(
                'Tandai Lokasi Tempat Tinggal Anda',
                size: 14,
                color: Utils.colorFromHex(ColorCode.bluePrimary),
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: ()=>Navigator.pushNamed(context, '/maps').
                then((value){
                  ModelLocation model = value;
                  widget.bloc.changeLatLon(double.parse(model.latitude), double.parse(model.longitude));
                }),
                child: StreamBuilder(
                  stream: widget.bloc.finishPinLoc,
                  builder: (context, snapshot) {
                    bool pinLoc = false;
                    if(snapshot.data != null){
                      pinLoc = snapshot.data;
                    }
                    return Container(
                        height: 85,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage(pinLoc ? ImageConstant.map_active:ImageConstant.map_inactive),
                            fit: BoxFit.cover,
                          ),
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: pinLoc ?  Colors.green : Colors.grey),
                          SizedBox(width: 10),
                          TextAvenir( pinLoc ? 'Lokasi sudah dipilih':'Ketuk untuk menandai Lokasi')
                        ],
                      ),
                    );
                  }
                ),
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
        ),
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
    FocusScope.of(context).requestFocus(new FocusNode());
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
                  height: size.height - size.height * 0.05,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        height: 5,
                        width: 60,
                        decoration: ConstantStyle.boxButton(radius: 15, color: Colors.grey.shade400),
                      ),
                      SizedBox(height: 10),
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
                                              Text(data[index].nama, textScaleFactor: 1.0,),
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

  showPicker(){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        // backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
