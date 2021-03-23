import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class BiodataView extends StatefulWidget {
  @override
  _BiodataViewState createState() => _BiodataViewState();
}

class _BiodataViewState extends State<BiodataView> {
  AuthBloc bloc = AuthBloc();
  List<String> dataGender = [];
  String genderSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataGender.add('Laki-laki');
    dataGender.add('Perempuan');

    bloc.getProvinsi();

    bloc.messageError.listen((event) {
      if(event != null){
        Utils.alertError(context, event, () { });
      }
    });

    bloc.allowDataDiri.listen((event) {
      if(event != null){
        if(event){
          // Utils.infoDialog(context, 'Informasi', 'Registrasi berhasil', () {
          //   Navigator.popAndPushNamed(context, '/login');
          // });
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextAvenir('Perbaharui Data', size: 20, color: Utils.colorFromHex(ColorCode.bluePrimary),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.add, color: Utils.colorFromHex(ColorCode.bluePrimary))
          )
        ],
      ),
      body: Container(
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
                              hintText: 'Nama lengkap sesaui KTP',
                              contentPadding: EdgeInsets.only(bottom:16)
                          ),
                        )
                    ),
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
                            Text('+62', style: TextStyle(fontSize: 16),),
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
                                    contentPadding: EdgeInsets.only(bottom:15)
                                ),
                                onChanged: (val){
                                  if(val[0] == '0'){
                                    bloc.edtNoTlp.text = val.replaceFirst(new RegExp(r'^0+'), '');
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                    ),
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
                        )
                    ),
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
                        )
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
                                'Tempat Lahir',
                                size: 14,
                                color: Utils.colorFromHex(ColorCode.bluePrimary),
                              ),
                              SizedBox(height: 5),
                              BoxBorderDefault(
                                  child: TextField(
                                    controller: bloc.edtTmptLahir,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: ConstantStyle.decorTextField,
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
                                  bloc.openDatePicker(context);
                                },
                                child: BoxBorderDefault(
                                    child: TextField(
                                      controller: bloc.edtTglLahir,
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(bottom:16)
                                      ),
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
                              BoxBorderDefault(
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: TextAvenir(
                                          'Jenis Kelamin',
                                          size: 12,
                                        ),
                                        value: genderSelected,
                                        items: dataGender.map((value) {
                                          return DropdownMenuItem(
                                            child: Container(
                                                margin: EdgeInsets.symmetric(horizontal: 10),
                                                child: Text(value)),
                                            value: value,
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          bloc.changeGender(value);
                                          setState(() {
                                            genderSelected = value;
                                          });
                                          // widget.bloc.pilihJenisKelamin(value);
                                        },
                                      )
                                  )
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
                          controller: bloc.edtAlamatKtp,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: ConstantStyle.decorTextField,
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
                          controller: bloc.edtProvinsi,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: ConstantStyle.decorTextField,
                          enabled: false,
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
                                        controller: bloc.edtKotaKab,
                                        textAlignVertical: TextAlignVertical.center,
                                        decoration: ConstantStyle.decorTextField,
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
                                  stream: bloc.downloadKec,
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
                                                  controller: bloc.edtKecamatan,
                                                  textAlignVertical: TextAlignVertical.center,
                                                  decoration: ConstantStyle.decorTextField,
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
                                  stream: bloc.downloadKel,
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
                                                  controller: bloc.edtDesa,
                                                  textAlignVertical: TextAlignVertical.center,
                                                  decoration: ConstantStyle.decorTextField,
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
                                          controller: bloc.edtRT,
                                          textAlignVertical: TextAlignVertical.center,
                                          keyboardType: TextInputType.number,
                                          decoration: ConstantStyle.decorTextField,
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
                                          controller: bloc.edtRW,
                                          textAlignVertical: TextAlignVertical.center,
                                          keyboardType: TextInputType.number,
                                          decoration: ConstantStyle.decorTextField,
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
                                    controller: bloc.edtKodePos,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.number,
                                    decoration: ConstantStyle.decorTextField,
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
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.15)
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Utils.colorFromHex(ColorCode.blueSecondary)
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: TextAvenir('Simpan', color: Colors.white, size: 18,),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  getDataFinder(String type){
    switch(type){
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

  finding(String type, String param){
    switch(type){
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

  setFindingValue(String type, dynamic data){
    switch(type){
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
                          stream: dataSink,
                          builder: (context, snapshot) {
                            List<dynamic> data = [];
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
                                              Text(data[index].nama),
                                              SizedBox(height: 5),
                                              Container(height: 0.8, width: double.infinity, color: Colors.grey[200],)
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
