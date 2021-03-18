import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kua/api/api.dart';
import 'package:kua/model/kabupaten/all_kabupaten.dart';
import 'package:kua/model/kabupaten/data_kabupaten.dart';
import 'package:kua/model/kecamatan/all_kecamatan.dart';
import 'package:kua/model/kecamatan/data_kecamatan.dart';
import 'package:kua/model/kelurahan/all_kelurahan.dart';
import 'package:kua/model/kelurahan/data_kelurahan.dart';
import 'package:kua/model/provinsi/all_provinsi.dart';
import 'package:kua/model/provinsi/data_provinsi.dart';
import 'package:kua/model/user/user.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/local_data.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc{

  final _typing = PublishSubject<bool>();
  final _showPass = PublishSubject<bool>();
  final _remember = PublishSubject<bool>();
  final _regisScreen = PublishSubject<int>();
  final _jenisKelamin = PublishSubject<String>();
  final _imageKtp = PublishSubject<File>();
  final _messageError = PublishSubject<String>();
  final _allowFotoKtpUser = PublishSubject<bool>();
  final _allowDataDiri = PublishSubject<bool>();
  final _loginSucces = PublishSubject<bool>();
  final _emailHasTaken = PublishSubject<bool>();
  final _typingPass = PublishSubject<bool>();
  final _typingRePass = PublishSubject<bool>();
  final _showPassData = PublishSubject<bool>();
  final _showRePassData = PublishSubject<bool>();

  final _downloadProvinsi = PublishSubject<bool>();
  final _downloadKab = PublishSubject<bool>();
  final _downloadKec = PublishSubject<bool>();
  final _downloadKel = PublishSubject<bool>();

  final _dataProvinsi = PublishSubject<List<DataProvinsi>>();
  final _dataKotaKab = PublishSubject<List<DataKabupaten>>();
  final _dataKecamatan = PublishSubject<List<DataKecamatan>>();
  final _dataKelurahan = PublishSubject<List<DataKelurahan>>();

  Stream<bool> get typing => _typing.stream;
  Stream<bool> get showPass => _showPass.stream;
  Stream<bool> get remember => _remember.stream;
  Stream<int> get regisScreen => _regisScreen.stream;
  Stream<String> get jenisKelamin => _jenisKelamin.stream;
  Stream<File> get imageKtp => _imageKtp.stream;
  Stream<String> get messageError => _messageError.stream;
  Stream<bool> get allowFotoKtpUser => _allowFotoKtpUser.stream;
  Stream<bool> get allowDataDiri => _allowDataDiri.stream;
  Stream<bool> get loginSucces => _loginSucces.stream;
  Stream<bool> get emailHasTaken => _emailHasTaken.stream;
  Stream<bool> get typingPass => _typingPass.stream;
  Stream<bool> get typingRePass => _typingRePass.stream;
  Stream<bool> get showPassData => _showPassData.stream;
  Stream<bool> get showRePassData => _showRePassData.stream;

  Stream<bool> get downloadProvinsi => _downloadProvinsi.stream;
  Stream<bool> get downloadKab => _downloadKab.stream;
  Stream<bool> get downloadKec => _downloadKec.stream;
  Stream<bool> get downloadKel => _downloadKel.stream;

  Stream<List<DataProvinsi>> get dataProvinsi => _dataProvinsi.stream;
  Stream<List<DataKabupaten>> get dataKotaKab => _dataKotaKab.stream;
  Stream<List<DataKecamatan>> get dataKecamatan => _dataKecamatan.stream;
  Stream<List<DataKelurahan>> get dataKelurahan => _dataKelurahan.stream;

  //login
  TextEditingController _edtUsername = new TextEditingController();
  TextEditingController _edtPassword = new TextEditingController();
  TextEditingController get edtUsername => _edtUsername;
  TextEditingController get edtPassword => _edtPassword;

  //registrasi data
  TextEditingController _edtNamaLengkap = new TextEditingController();
  TextEditingController _edtNoTlp = new TextEditingController();
  TextEditingController _edtEmail = new TextEditingController();
  TextEditingController _edtPass = new TextEditingController();
  TextEditingController _edtRePass = new TextEditingController();
  TextEditingController get edtNamaLengkap => _edtNamaLengkap;
  TextEditingController get edtNoTlp => _edtNoTlp;
  TextEditingController get edtEmail => _edtEmail;
  TextEditingController get edtPass => _edtPass;
  TextEditingController get edtRePass => _edtRePass;

  //registrasi foto
  TextEditingController _edtKtp = new TextEditingController();
  TextEditingController get edtKtp => _edtKtp;

  //registrasi datadiri
  TextEditingController _edtTmptLahir = new TextEditingController();
  TextEditingController _edtTglLahir = new TextEditingController();
  TextEditingController _edtAlamatKtp = new TextEditingController();
  TextEditingController _edtProvinsi = new TextEditingController();
  TextEditingController _edtKotaKab = new TextEditingController();
  TextEditingController _edtDesa = new TextEditingController();
  TextEditingController _edtKecamatan = new TextEditingController();
  TextEditingController _edtRT = new TextEditingController();
  TextEditingController _edtRW = new TextEditingController();
  TextEditingController _edtKodePos = new TextEditingController();
  TextEditingController get edtTmptLahir => _edtTmptLahir;
  TextEditingController get edtTglLahir => _edtTglLahir;
  TextEditingController get edtAlamatKtp => _edtAlamatKtp;
  TextEditingController get edtProvinsi => _edtProvinsi;
  TextEditingController get edtKotaKab => _edtKotaKab;
  TextEditingController get edtDesa => _edtDesa;
  TextEditingController get edtKecamatan => _edtKecamatan;
  TextEditingController get edtRT => _edtRT;
  TextEditingController get edtRW => _edtRW;
  TextEditingController get edtKodePos => _edtKodePos;

  //forgot password
  TextEditingController _edtForgotPassword = new TextEditingController();
  TextEditingController get edtForgotPassword => _edtForgotPassword;

  TextEditingController pinPutController = TextEditingController();

  int _registViewAt = 0; // 0:register data, 1:register foto, 2:register alamat
  int get registViewAt => _registViewAt;

  changeViewRegist(int val){
    _registViewAt = val;
    _regisScreen.sink.add(val);
  }

  int _gender = -1; // 0:register data, 1:register foto, 2:register alamat
  int get gender => _gender;

  changeGender(String val){
    if(val == 'Laki-laki'){
      _gender = 0;
    }else{
      _gender = 1;
    }
  }

  bool _isRemember = false;
  bool get isRemember => _isRemember;

  String _strGender = '';
  String get strGender => _strGender;

  String _strPhotoName = '';
  String get strPhotoName => _strPhotoName;
  String _img64 = '';
  String get img64 => _img64;

  passTyping(bool val){
    _typing.sink.add(val);
  }

  passDataTyping(bool val){
    _typingPass.sink.add(val);
  }

  rePassDataTyping(bool val){
    _typingRePass.sink.add(val);
  }

  showPassword(bool val){
    _showPass.sink.add(val);
  }

  openPassData(bool val){
    _showPassData.sink.add(val);
  }

  openRePassData(bool val){
    _showRePassData.sink.add(val);
  }

  changeRemember(bool val){
    _isRemember = val;
    _remember.sink.add(val);
  }

  pilihJenisKelamin(String val){
    _strGender = val;
    _jenisKelamin.sink.add(val);
  }

  File _imgFotoKtp;
  File get imgFotoKtp => _imgFotoKtp;

  changeImage(File val){
    _strPhotoName = val.path.split('/').last;
    final bytes = val.readAsBytesSync();
    _img64 = base64Encode(bytes);
    _imgFotoKtp = val;
    _imageKtp.sink.add(val);
  }

  validasiDataUser(){
    if(edtNamaLengkap.text == ''){
      _messageError.sink.add('Nama Lengkap harus diisi!');
    }else if(edtNoTlp.text == ''){
      _messageError.sink.add('No Telepon harus diisi!');
    }else if(edtEmail.text == ''){
      _messageError.sink.add('Email harus diisi!');
    }else if(edtPass.text == ''){
      _messageError.sink.add('Kata Sandi harus diisi!');
    }else if(edtRePass.text == ''){
      _messageError.sink.add('Ulang Kata Sandi harus diisi!');
    }else if(edtRePass.text != edtPass.text){
      _messageError.sink.add('Kata Sandi dan Ulang Kata Sandi tidak sama!');
    }else{
      emailChecking();
    }
  }

  validasiFotoKtp(){
    if(edtKtp.text == ''){
      _messageError.sink.add('Nomor KTP harus diisi!');
    }else if(_imgFotoKtp == null){
      _messageError.sink.add('Foto KTP harus diisi!');
    }else{
      _allowFotoKtpUser.sink.add(true);
    }
  }

  validasiDataDiri(BuildContext context){
    if(edtTmptLahir.text == ''){
      _messageError.sink.add('Tempat Lahir harus diisi!');
    }else if(edtTglLahir.text == ''){
      _messageError.sink.add('Tanggal Lahir harus diisi!');
    }else if(gender < 0){
      _messageError.sink.add('Jenis Kelamin harus dipilih!');
    }else if(edtAlamatKtp.text == ''){
      _messageError.sink.add('Alamat harus diisi!');
    }else if(edtKotaKab.text == ''){
      _messageError.sink.add('Kota harus diisi!');
    }else if(edtDesa.text == ''){
      _messageError.sink.add('Desa/Kelurahan Sandi tidak sama!');
    }else if(edtKecamatan.text == ''){
      _messageError.sink.add('Kecamatan harus diisi!');
    }else if(edtRT.text == ''){
      _messageError.sink.add('RT harus diisi!');
    }else if(edtRW.text == ''){
      _messageError.sink.add('RW harus diisi!');
    }else{
      postRegister(context);
    }
  }

  openDatePicker(BuildContext context) async {
    DateTime dateTime;
    dateTime = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate:  dateTime,
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2100)
    );
    if (picked != null){
      final dateFormat = DateFormat("yyyy-MM-dd");
      _edtTglLahir.text = dateFormat.format(picked);
    }
  }

  validasiLogin(BuildContext context){
    if(edtUsername.text == ''){
      _messageError.sink.add('Email/No Telepon harus diisi!');
    }else if(edtPassword.text == ''){
      _messageError.sink.add('Password harus diisi!');
    }else{
      postLogin(context);
    }
  }

  emailChecking(){
    API.emailChecking(edtEmail.text, (result, error) {
      if(result != null){
        if(result['code'] == 200){
          if(result['error'] == true){
            _messageError.sink.add(result['message']);
          }else{
            _emailHasTaken.sink.add(true);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }
//=================== provinsi ================
  List<DataProvinsi> _allProvinsi = [];
  List<DataProvinsi> get allProvinsi => _allProvinsi;

  getProvinsi(){
    _downloadProvinsi.sink.add(true);
    API.getProvinsi((result, error) {
      if(result != null){
        if(result['code'] == 200){
          var json = result as Map<String, dynamic>;
          var data = AllProvinsi.fromJson(json);
          if(data != null){
            _allProvinsi = data.data;
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
      _downloadProvinsi.sink.add(false);
    });
  }

  findProvinsi(String val){
    var data = allProvinsi.where((element) => element.nama.toLowerCase().contains(val.toLowerCase()));
    if(data != null){
      _dataProvinsi.sink.add(data.toList());
    }
    return data;
  }

  DataProvinsi _provinsi;
  DataProvinsi get provinsi => _provinsi;
  changeProvinsi(DataProvinsi val){
    _provinsi = val;
    _edtProvinsi.text = val.nama;
    getKabupaten(val.id.toString());
  }

  //=================== Kota Kabupaten ================

  List<DataKabupaten> _allKabupaten = new List();
  List<DataKabupaten> get allKabupaten => _allKabupaten;

  getKabupaten(String provinsiId){
    _downloadKab.sink.add(true);
    API.getKabupaten(provinsiId, (result, error) {
      if(result != null){
        if(result['code'] == 200){
          var json = result as Map<String, dynamic>;
          var data = AllKabupaten.fromJson(json);
          if(data != null){
            _allKabupaten = data.data;
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
      _downloadKab.sink.add(false);
    });
  }

  findKabupaten(String val){
    var data = allKabupaten.where((element) => element.nama.toLowerCase().contains(val.toLowerCase()));
    if(data != null){
      _dataKotaKab.sink.add(data.toList());
    }
    return data;
  }

  DataKabupaten _kabupaten;
  DataKabupaten get kabupaten => _kabupaten;

  changeKabupaten(DataKabupaten val){
    _kabupaten = val;
    _edtKotaKab.text = val.nama;
    getKecamatan(val.id.toString());
  }

  //=================== kecamatan ================

  List<DataKecamatan> _allKecamatan = new List();
  List<DataKecamatan> get allKecamatan => _allKecamatan;

  getKecamatan(String kabId){
    _downloadKec.sink.add(true);
    API.getKecamatan(kabId, (result, error) {
      if(result != null){
        if(result['code'] == 200){
          var json = result as Map<String, dynamic>;
          var data = AllKecamatan.fromJson(json);
          if(data != null){
            _allKecamatan = data.data;
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
      _downloadKec.sink.add(false);
    });
  }

  findKecamatan(String val){
    var data = allKecamatan.where((element) => element.nama.toLowerCase().contains(val.toLowerCase()));
    if(data != null){
      _dataKecamatan.sink.add(data.toList());
    }
    return data;
  }

  DataKecamatan _kecamatan;
  DataKecamatan get kecamatan => _kecamatan;

  changeKecamatan(DataKecamatan val){
    _kecamatan = val;
    _edtKecamatan.text = val.nama;
    getKelurahan(val.id.toString());
  }

  //=================== keurahan ================

  List<DataKelurahan> _allKelurahan = new List();
  List<DataKelurahan> get allKelurahan => _allKelurahan;

  getKelurahan(String kecId){
    _downloadKel.sink.add(true);
    API.getKelurahan(kecId, (result, error) {
      if(result != null){
        if(result['code'] == 200){
          var json = result as Map<String, dynamic>;
          var data = AllKelurahan.fromJson(json);
          if(data != null){
            _allKelurahan = data.data;
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
      _downloadKel.sink.add(false);
    });
  }

  findKelurahan(String val){
    var data = allKelurahan.where((element) => element.nama.toLowerCase().contains(val.toLowerCase()));
    if(data != null){
      _dataKelurahan.sink.add(data.toList());
    }
    return data;
  }

  DataKelurahan _kelurahan;
  DataKelurahan get kelurahan => _kelurahan;

  changeKelurahan(DataKelurahan val){
    _kelurahan = val;
    _edtDesa.text = val.nama;
  }

  postLogin(BuildContext context){
    Utils.progressDialog(context);
    API.postLogin(edtUsername.text, edtPassword.text, (result, error) {
      if(result != null){
        if(result['code'] == 200){
          var json = result as Map<String, dynamic>;
          var data = UserModel.fromJson(json['data']);
          if(data != null){
            LocalData.saveUser(data);
          }
        }
        _loginSucces.sink.add(true);
      }else{
        _messageError.sink.add(error['message']);
      }
      Navigator.of(context).pop();
    });
  }

  postRegister(BuildContext context){
    Utils.progressDialog(context);
    API.postRegister(
      edtNamaLengkap.text,
      edtEmail.text,
      edtPass.text,
      edtNoTlp.text,
      edtKtp.text,
      strPhotoName,
      img64,
      edtTmptLahir.text,
      edtTglLahir.text,
      gender.toString(),
      edtAlamatKtp.text,
      provinsi.id.toString(),
      kabupaten.id.toString(),
      kecamatan.id.toString(),
      kelurahan.id.toString(),
      edtRT.text,
      edtRW.text,
      edtKodePos.text,
        (result, error) {
      if(result != null){
        _allowDataDiri.sink.add(true);
      }
      Navigator.of(context).pop();
    });
  }

  forgotPassword(BuildContext context){
    Utils.progressDialog(context);
    if(edtForgotPassword.text == ''){
      _messageError.sink.add('Email harus diisi!');
      return;
    }
    API.forgotPassword(edtForgotPassword.text, (result, error) {
      Navigator.of(context).pop();
      if(result != null){
        _messageError.sink.add(result['message']);
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }
}