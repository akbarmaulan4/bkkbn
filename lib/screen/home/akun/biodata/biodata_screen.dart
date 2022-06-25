import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/bloc/map_bloc.dart';
import 'package:kua/model/model_location.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/util/local_data.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class BiodataView extends StatefulWidget {
  @override
  _BiodataViewState createState() => _BiodataViewState();
}

class _BiodataViewState extends State<BiodataView> {
  AuthBloc bloc = AuthBloc();
  MapBloc mapBloc = MapBloc();
  List<String> dataGender = [];
  String genderSelected;

  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataGender.add('Laki-laki');
    dataGender.add('Perempuan');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadData(context);
    });

    bloc.messageError.listen((event) {
      if (event != null) {
        Utils.alertError(context, event, () {});
      }
    });

    bloc.allowDataDiri.listen((event) {
      if (event != null) {
        Utils.infoDialog(context, 'Informasi', 'Perbaharuan Data Berhasil', () {
              // Navigator.popAndPushNamed(context, '/login');
        });
      }
    });
  }

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxWidth: 1024,
        maxHeight: 768);
    // ImagePicker.pickImage()
    //     ?.then((file) => file.readAsBytes())
    //     ?.then((bytes) => FlutterImageCompress.compressWithList(bytes));
    setState(() {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        bloc.changeImage(image);
        setState(() {
          _image = image;
        });
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 1024,
        maxHeight: 768);
    setState(() async {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        bloc.changeImage(image);
        _image = image;
      } else {
        print('No image selected.');
      }
    });
  }

  loadData(BuildContext context) async {
    var user = await LocalData.getUser();
    bloc.getProfile(context, user.id.toString());
    bloc.getProvinsi();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextAvenir(
          'Perbaharui Data',
          size: 20,
          color: Utils.colorFromHex(ColorCode.bluePrimary),
        ),
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios_rounded,
                color: Utils.colorFromHex(ColorCode.bluePrimary))),
      ),
      body: MediaQuery(
        data: scaleFactor,
        child: Container(
          color: Utils.colorFromHex(ColorCode.softGreyElsimil),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            StreamBuilder(
                              stream: bloc.imageKtp,
                              builder: (context, snapshot) {
                                File img = bloc.imgFotoKtp;
                                if (snapshot.data != null) {
                                  img = snapshot.data;
                                }
                                return img != null ? Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Utils.colorFromHex(ColorCode.bluePrimary), width: 1.5)
                                  ),
                                  child: ClipOval(
                                    child: Image.file(_image, width: 100, height: 100, fit: BoxFit.cover),
                                  )) : StreamBuilder(
                                      stream: bloc.picBiodata,
                                      builder: (context, snapshot) {
                                        String urlImg = '';
                                        if (snapshot.data != null) {
                                          urlImg = snapshot.data;
                                        }
                                        return Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Utils.colorFromHex(ColorCode.bluePrimary), width: 1.5)
                                          ),
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) => Center(child: Image.asset(ImageConstant.placeHolderElsimil)),
                                              imageUrl: urlImg, //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2U_L6KJsOv1ZX5v-JScbk8ZO_ZEe5CwOvmA&usqp=CAU',
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error)=>Image.asset(ImageConstant.placeHolderElsimil),
                                            ),
                                          ),
                                        );
                                      });
                                }),
                            Positioned(
                                bottom: 0,
                                right: 5,
                                child: InkWell(
                                    onTap: () => showPicker(),
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.grey,
                                    )))
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      TextAvenir(
                        'Nama Lengkap',
                        size: 14,
                        color: Utils.colorFromHex(ColorCode.bluePrimary),
                      ),
                      SizedBox(height: 5),
                      BoxBorderDefault(
                          child: TextField(
                            controller: bloc.edtNamaLengkap,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nama lengkap sesuai KTP',
                                hintStyle:
                                TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                contentPadding: EdgeInsets.only(bottom: 16)),
                          )),
                      SizedBox(height: 15),
                      TextAvenir(
                        'No Telepon',
                        size: 14,
                        color: Utils.colorFromHex(ColorCode.bluePrimary),
                      ),
                      SizedBox(height: 5),
                      BoxBorderDefault(
                          child: Row(
                            children: [
                              Text(
                                '+62',
                                style: TextStyle(fontSize: 16),
                                textScaleFactor: 1.0,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: bloc.edtNoTlp,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(12),
                                    new BlacklistingTextInputFormatter(
                                        new RegExp('[\\-|\\,|\\.]')),
                                  ],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(bottom: 15)),
                                  onChanged: (val) {
                                    if (val[0] == '0') {
                                      bloc.edtNoTlp.text =
                                          val.replaceFirst(new RegExp(r'^0+'), '');
                                    }
                                  },
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 15),
                      TextAvenir(
                        'Email',
                        size: 14,
                        color: Utils.colorFromHex(ColorCode.bluePrimary),
                      ),
                      SizedBox(height: 5),
                      BoxBorderDefault(
                          child: TextField(
                            controller: bloc.edtEmail,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.emailAddress,
                            decoration: ConstantStyle.decorTextField,
                          )),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextAvenir(
                        'No KTP',
                        size: 14,
                        color: Utils.colorFromHex(ColorCode.bluePrimary),
                      ),
                      SizedBox(height: 5),
                      BoxBorderDefault(
                          child: TextField(
                            controller: bloc.edtKtp,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(16),
                              new BlacklistingTextInputFormatter(
                                  new RegExp('[\\-|\\,|\\.]')),
                            ],
                            decoration: ConstantStyle.decorTextField,
                            style: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                            enabled: false,
                          )),
                      SizedBox(height: 15),
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
                                  color:
                                  Utils.colorFromHex(ColorCode.bluePrimary),
                                ),
                                SizedBox(height: 5),
                                BoxBorderDefault(
                                    child: TextField(
                                      controller: bloc.edtTmptLahir,
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: ConstantStyle.decorTextField,
                                      style: TextStyle(
                                          color: Utils.colorFromHex('#CCCCCC')),
                                      enabled: false,
                                    )),
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
                                  'Tanggal Lahir',
                                  size: 14,
                                  color:
                                  Utils.colorFromHex(ColorCode.bluePrimary),
                                ),
                                SizedBox(height: 5),
                                InkWell(
                                  onTap: () {
                                    bloc.openDatePicker(context);
                                  },
                                  child: BoxBorderDefault(
                                      child: TextField(
                                        controller: bloc.edtTglLahir,
                                        textAlignVertical: TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            enabled: false,
                                            contentPadding:
                                            EdgeInsets.only(bottom: 16)),
                                        enabled: false,
                                        style: TextStyle(
                                            color: Utils.colorFromHex('#CCCCCC')),
                                      )),
                                )
                              ],
                            ),
                          ),
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
                                  color:
                                  Utils.colorFromHex(ColorCode.bluePrimary),
                                ),
                                SizedBox(height: 5),
                                StreamBuilder(
                                    stream: bloc.jenisKelamin,
                                    builder: (context, snapshot) {
                                      String data = bloc.strGender;
                                      if (snapshot.data != null) {
                                        data = snapshot.data;
                                      }
                                      return BoxBorderDefault(
                                        child: TextField(
                                          controller: bloc.edtGender,
                                          textAlignVertical:
                                          TextAlignVertical.center,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              enabled: false,
                                              contentPadding:
                                              EdgeInsets.only(bottom: 16)),
                                          enabled: false,
                                          style: TextStyle(
                                              color: Utils.colorFromHex(
                                                  '#CCCCCC')),
                                        ),
                                        // child: DropdownButtonHideUnderline(
                                        //     child: DropdownButton(
                                        //       hint: TextAvenir(
                                        //         'Jenis Kelamin',
                                        //         size: 12,
                                        //       ),
                                        //       value: data,
                                        //       items: dataGender.map((value) {
                                        //         return DropdownMenuItem(
                                        //           child: Container(
                                        //               margin: EdgeInsets.symmetric(horizontal: 10),
                                        //               child: Text(value)),
                                        //           value: value,
                                        //         );
                                        //       }).toList(),
                                        //       onChanged: (value) {
                                        //         // bloc.pilihJenisKelamin(value);
                                        //       },
                                        //     )
                                        // )
                                      );
                                    }),
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
                                  color:
                                  Utils.colorFromHex(ColorCode.bluePrimary),
                                ),
                                SizedBox(height: 5),
                                BoxBorderDefault(
                                    child: TextField(
                                      controller: bloc.edtNikah,
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabled: false,
                                          contentPadding:
                                          EdgeInsets.only(bottom: 16)),
                                      enabled: false,
                                      style: TextStyle(
                                          color: Utils.colorFromHex('#CCCCCC')),
                                    ))
                              ],
                            ),
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
                            controller: bloc.edtAlamatKtp,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: ConstantStyle.decorTextField,
                            enabled: false,
                            style: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                          )),
                      SizedBox(height: 15),
                      TextAvenir(
                        'Provinsi',
                        size: 14,
                        color: Utils.colorFromHex(ColorCode.bluePrimary),
                      ),
                      SizedBox(height: 5),
                      BoxBorderDefault(
                        child: InkWell(
                          // onTap: ()=>showFinder('provinsi'),
                          child: TextField(
                            controller: bloc.edtProvinsi,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: ConstantStyle.decorTextField,
                            enabled: false,
                            style:
                            TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextAvenir(
                        'Kota',
                        size: 14,
                        color: Utils.colorFromHex(ColorCode.bluePrimary),
                      ),
                      SizedBox(height: 5),
                      StreamBuilder(
                          stream: bloc.downloadKab,
                          builder: (context, snapshot) {
                            var load = false;
                            if (snapshot.data != null) {
                              load = snapshot.data;
                            }
                            return BoxBorderDefault(
                                child: InkWell(
                                  // onTap: ()=>showFinder('kota'),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: bloc.edtKotaKab,
                                          textAlignVertical:
                                          TextAlignVertical.center,
                                          decoration: ConstantStyle.decorTextField,
                                          enabled: false,
                                          style: TextStyle(
                                              color: Utils.colorFromHex('#CCCCCC')),
                                        ),
                                      ),
                                      load
                                          ? Container(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator())
                                          : SizedBox(),
                                      SizedBox(width: load ? 10 : 0)
                                    ],
                                  ),
                                ));
                          }),
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
                                  color:
                                  Utils.colorFromHex(ColorCode.bluePrimary),
                                ),
                                SizedBox(height: 5),
                                StreamBuilder(
                                    stream: bloc.downloadKec,
                                    builder: (context, snapshot) {
                                      var load = false;
                                      if (snapshot.data != null) {
                                        load = snapshot.data;
                                      }
                                      return BoxBorderDefault(
                                          child: InkWell(
                                            // onTap: ()=>showFinder('kecamatan'),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    controller: bloc.edtKecamatan,
                                                    textAlignVertical:
                                                    TextAlignVertical.center,
                                                    decoration: ConstantStyle
                                                        .decorTextField,
                                                    enabled: false,
                                                    style: TextStyle(
                                                        color: Utils.colorFromHex(
                                                            '#CCCCCC')),
                                                  ),
                                                ),
                                                load
                                                    ? Container(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                    CircularProgressIndicator())
                                                    : SizedBox(),
                                                SizedBox(width: load ? 10 : 0)
                                              ],
                                            ),
                                          ));
                                    }),
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
                                  color:
                                  Utils.colorFromHex(ColorCode.bluePrimary),
                                ),
                                SizedBox(height: 5),
                                StreamBuilder(
                                    stream: bloc.downloadKel,
                                    builder: (context, snapshot) {
                                      var load = false;
                                      if (snapshot.data != null) {
                                        load = snapshot.data;
                                      }
                                      return BoxBorderDefault(
                                          child: InkWell(
                                            // onTap: ()=>showFinder('kelurahan'),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    controller: bloc.edtDesa,
                                                    textAlignVertical:
                                                    TextAlignVertical.center,
                                                    decoration: ConstantStyle
                                                        .decorTextField,
                                                    enabled: false,
                                                    style: TextStyle(
                                                        color: Utils.colorFromHex(
                                                            '#CCCCCC')),
                                                  ),
                                                ),
                                                load
                                                    ? Container(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                    CircularProgressIndicator())
                                                    : SizedBox(),
                                                SizedBox(width: load ? 10 : 0)
                                              ],
                                            ),
                                          ));
                                    }),
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      TextAvenir(
                                        'RT',
                                        size: 14,
                                        color: Utils.colorFromHex(
                                            ColorCode.bluePrimary),
                                      ),
                                      SizedBox(height: 5),
                                      BoxBorderDefault(
                                          child: TextField(
                                            controller: bloc.edtRT,
                                            textAlignVertical:
                                            TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            decoration:
                                            ConstantStyle.decorTextField,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(3),
                                              new BlacklistingTextInputFormatter(
                                                  new RegExp('[\\-|\\,|\\.]')),
                                            ],
                                            style: TextStyle(
                                                color:
                                                Utils.colorFromHex('#CCCCCC')),
                                            enabled: false,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      TextAvenir(
                                        'RW',
                                        size: 14,
                                        color: Utils.colorFromHex(
                                            ColorCode.bluePrimary),
                                      ),
                                      SizedBox(height: 5),
                                      BoxBorderDefault(
                                          child: TextField(
                                            controller: bloc.edtRW,
                                            textAlignVertical:
                                            TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            decoration:
                                            ConstantStyle.decorTextField,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(3),
                                              new BlacklistingTextInputFormatter(
                                                  new RegExp('[\\-|\\,|\\.]')),
                                            ],
                                            style: TextStyle(
                                                color:
                                                Utils.colorFromHex('#CCCCCC')),
                                            enabled: false,
                                          )),
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
                                  color:
                                  Utils.colorFromHex(ColorCode.bluePrimary),
                                ),
                                SizedBox(height: 5),
                                BoxBorderDefault(
                                    child: TextField(
                                      controller: bloc.edtKodePos,
                                      textAlignVertical: TextAlignVertical.center,
                                      keyboardType: TextInputType.number,
                                      decoration: ConstantStyle.decorTextField,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(5),
                                        new BlacklistingTextInputFormatter(
                                            new RegExp('[\\-|\\,|\\.]')),
                                      ],
                                      style: TextStyle(
                                          color: Utils.colorFromHex('#CCCCCC')),
                                      enabled: false,
                                    )),
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
                          bloc.changeLatLon(double.parse(model.latitude), double.parse(model.longitude));
                        }),
                        child: StreamBuilder(
                            stream: bloc.finishPinLoc,
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
                      // SizedBox(height: 15),
                      // TextAvenir(
                      //   'Rencana Tanggal Pernikahan',
                      //   size: 14,
                      //   color: Utils.colorFromHex(ColorCode.bluePrimary),
                      // ),
                      // SizedBox(height: 5),
                      // InkWell(
                      //   onTap: () {
                      //     bloc.openDatePickerMarriage(context);
                      //   },
                      //   child: BoxBorderDefault(
                      //       child: TextField(
                      //     controller: bloc.edtTglNikah,
                      //     textAlignVertical: TextAlignVertical.center,
                      //     decoration: InputDecoration(
                      //         border: InputBorder.none,
                      //         enabled: false,
                      //         contentPadding: EdgeInsets.only(bottom: 16)),
                      //     enabled: false,
                      //     style:
                      //         TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                      //   )),
                      // )
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.15)
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: size.height * 0.15,
      //   child: Center(
      //     child: TextAvenir('Simpan',  size: 18,),
      //   ),
      // ),
      floatingActionButton: InkWell(
        onTap: () async {
          var user = await LocalData.getUser();
          bloc.validasiUpdate(context, user.id.toString());
        },
        child: Container(
            alignment: Alignment.bottomCenter,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Utils.colorFromHex(ColorCode.blueSecondary)),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: TextAvenir(
                'Simpan',
                color: Colors.white,
                size: 18,
              ),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  getDataFinder(String type) {
    switch (type) {
      case 'provinsi':
        return bloc.dataProvinsi;
      case 'kota':
        return bloc.dataKotaKab;
      case 'kecamatan':
        return bloc.dataKecamatan;
      case 'kelurahan':
        return bloc.dataKelurahan;
    }
  }

  finding(String type, String param) {
    switch (type) {
      case 'provinsi':
        bloc.findProvinsi(param);
        break;
      case 'kota':
        bloc.findKabupaten(param);
        break;
      case 'kecamatan':
        bloc.findKecamatan(param);
        break;
      case 'kelurahan':
        bloc.findKelurahan(param);
        break;
    }
  }

  setFindingValue(String type, dynamic data) {
    switch (type) {
      case 'provinsi':
        bloc.changeProvinsi(data);
        break;
      case 'kota':
        bloc.changeKabupaten(data);
        break;
      case 'kecamatan':
        bloc.changeKecamatan(data);
        break;
      case 'kelurahan':
        bloc.changeKelurahan(data);
        break;
    }
  }

  void showFinder(String type) async {
    var size = MediaQuery.of(context).size;
    var dataSink = getDataFinder(type);
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
                            border: Border.all(color: Colors.grey[300])),
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
                              contentPadding: EdgeInsets.only(bottom: 7)),
                          onChanged: (val) {
                            finding(type, val);
                          },
                        ),
                      ),
                      StreamBuilder(
                          stream: dataSink,
                          builder: (context, snapshot) {
                            List<dynamic> data = [];
                            if (snapshot.data != null) {
                              data = snapshot.data;
                            }
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setFindingValue(type, data[index]);
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(data[index].nama),
                                              SizedBox(height: 5),
                                              Container(
                                                height: 0.8,
                                                width: double.infinity,
                                                color: Colors.grey[200],
                                              )
                                            ],
                                          )),
                                    );
                                  }),
                            );
                          }),
                    ],
                  ),
                );
              });
        });
  }

  showPicker() {
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
        });
  }
}
