
import 'package:flutter/cupertino.dart';
import 'package:kua/api/api.dart';
import 'package:kua/model/akun/bantuan/all_bantuan.dart';
import 'package:kua/model/akun/bantuan/all_bantuan_detail.dart';
import 'package:kua/model/akun/bantuan/bantuan_item.dart';
import 'package:kua/model/akun/bantuan/detail_bantuan_model.dart';
import 'package:kua/model/akun/biodata/all_couple.dart';
import 'package:kua/model/akun/biodata/all_waiting.dart';
import 'package:kua/model/akun/biodata/couple_item.dart';
import 'package:kua/model/riwayat/pasangan_item.dart';
import 'package:kua/model/riwayat/riwayat_item.dart';
import 'package:kua/model/user/user.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/local_data.dart';
import 'package:rxdart/rxdart.dart';

class AkunBloc{
  final _messageError = PublishSubject<String>();
  final _dataBantuan = PublishSubject<List<BantuanItem>>();
  final _detailBantuan = PublishSubject<DetailBantuanModel>();
  final _dataUser = PublishSubject<Map>();
  final _waitingCouple = PublishSubject<AllWaiting>();
  final _dataCouple = PublishSubject<List<CoupleItem>>();
  final _showInfoCouple = PublishSubject<bool>();
  final _addCouple = PublishSubject<bool>();
  final _confirmCouple = PublishSubject<bool>();
  final _canAddCouple = PublishSubject<bool>();
  final _dataRiwayat = PublishSubject<List<RiwayatItem>>();
  final _dataPasangan = PublishSubject<List<PasanganItem>>();
  final _showOldPass = PublishSubject<bool>();
  final _showNewPass = PublishSubject<bool>();
  final _showRePass = PublishSubject<bool>();
  final _typingOldPass = PublishSubject<bool>();
  final _typingNewPass = PublishSubject<bool>();
  final _typingRePass = PublishSubject<bool>();
  final _user = BehaviorSubject<UserModel>();

  Stream<List<BantuanItem>> get dataBantuan => _dataBantuan.stream;
  Stream<String> get messageError => _messageError.stream;
  Stream<DetailBantuanModel> get detailBantuan => _detailBantuan.stream;
  Stream<Map> get dataUser => _dataUser.stream;
  Stream<AllWaiting> get waitingCouple => _waitingCouple.stream;
  Stream<List<CoupleItem>> get dataCouple => _dataCouple.stream;
  Stream<bool> get showInfoCouple => _showInfoCouple.stream;
  Stream<bool> get addCouple => _addCouple.stream;
  Stream<bool> get confirmCouple => _confirmCouple.stream;
  Stream<bool> get canAddCouple => _canAddCouple.stream;
  Stream<List<RiwayatItem>> get dataRiwayat => _dataRiwayat.stream;
  Stream<List<PasanganItem>> get dataPasangan => _dataPasangan.stream;
  Stream<bool> get showOldPass => _showOldPass.stream;
  Stream<bool> get showNewPass => _showNewPass.stream;
  Stream<bool> get showRePass => _showRePass.stream;
  Stream<bool> get typingOldPass => _typingOldPass.stream;
  Stream<bool> get typingNewPass => _typingNewPass.stream;
  Stream<bool> get typingRePass => _typingRePass.stream;
  Stream<UserModel> get user => _user.stream;

  TextEditingController edtNoKtp = new TextEditingController();
  TextEditingController edtIdProfile = new TextEditingController();

  TextEditingController edtOldPass = new TextEditingController();
  TextEditingController edtNewPass = new TextEditingController();
  TextEditingController edtRePass = new TextEditingController();

  isTypingOldPass(bool val){
    _typingOldPass.sink.add(val);
  }
  isTypingNewPass(bool val){
    _typingNewPass.sink.add(val);
  }
  isTypingRePass(bool val){
    _typingRePass.sink.add(val);
  }

  changeOldPass(bool val){
    _showOldPass.sink.add(val);
  }
  changeNewPass(bool val){
    _showNewPass.sink.add(val);
  }
  changeRePass(bool val){
    _showRePass.sink.add(val);
  }

  bantuan(BuildContext context){
    Utils.progressDialog(context);
    API.bantuan((result, error) {
      Navigator.of(context).pop();
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          var data = AllBantuan.fromJson(json);
          if(data != null){
            _dataBantuan.sink.add(data.data);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  getDetailBantuan(BuildContext context, String id){
    Utils.progressDialog(context);
    API.detailBantuan(id, (result, error) {
      Navigator.of(context).pop();
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          var data = AllBantuanDetail.fromJson(json);
          if(data != null){
            _detailBantuan.sink.add(data.data[0]);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  getProfile(String id){
    API.getprofile(id, (result, error) {
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          var data = json['data'];
          Map dataModel = Map();
          dataModel.putIfAbsent('pic', () => data['pic']);
          dataModel.putIfAbsent('nama', () => data['name']);
          dataModel.putIfAbsent('umur', () => data['usia']);
          dataModel.putIfAbsent('alamat', () => data['alamat']);
          dataModel.putIfAbsent('kota', () => data['nama_kabupaten']);
          dataModel.putIfAbsent('profile_id', () => data['profile_id']);
          dataModel.putIfAbsent('no_ktp', () => data['no_ktp']);
          dataModel.putIfAbsent('gender', () => data['gender']);
          _dataUser.sink.add(dataModel);
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  loadUser() async{
    var user = await LocalData.getUser();
    if(user != null){
      getProfile(user.id.toString());
      _user.sink.add(user);
    }
  }

  int _totalPasangan = 0;
  int get totalPasangan => _totalPasangan;
  listSpouse(BuildContext context) async {
    Utils.progressDialog(context);
    var user = await LocalData.getUser();
    if(user != null){
      API.listSpouse(user.id.toString(), (result, error) {
        Navigator.of(context).pop();
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            var json = result as Map<String, dynamic>;
            var data = AllCouple.fromJson(json);
            if(data != null){
              _totalPasangan = data.data.length;
              _dataCouple.sink.add(data.data);
              canAddSpouse();
            }else{
              _messageError.sink.add('Terjadi kesalahan dalam menampilkan data');
            }
          }else{
            _messageError.sink.add(result['message']);
          }
        }else{
          _messageError.sink.add(error['message']);
        }
        pendingSpouse();
      });
    }
  }

  pendingSpouse() async {
    var user = await LocalData.getUser();
    if(user != null){
      API.pendingSpouse(user.id.toString(), (result, error) {
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            var json = result as Map<String, dynamic>;
            var data = AllWaiting.fromJson(json['data']);
            if(data != null){
              _waitingCouple.sink.add(data);
              if(data.waiting.isEmpty && totalPasangan < 1){
                _showInfoCouple.sink.add(true);
              }
              // if(data.waiting.isEmpty && totalPasangan < 1){
              //   _showInfoCouple.sink.add(false);
              // }
            }else{
              _messageError.sink.add('Terjadi kesalahan dalam menampilkan data');
            }
          }else{
            _messageError.sink.add(result['message']);
          }
        }else{
          _messageError.sink.add(error['message']);
        }
      });
    }
  }

  validationAddSpouse(BuildContext context){
    if(edtNoKtp.text == ''){
      _messageError.sink.add('No KTP Pasangan tidak boleh kosong');
    }else if(edtIdProfile.text == ''){
      _messageError.sink.add('ID Profil Pasangan tidak boleh kosong');
    }else{
      addSpouse(context);
    }
  }

  addSpouse(BuildContext context) async {
    var user = await LocalData.getUser();
    if(user != null){
      Utils.progressDialog(context);
      API.addSpouse(user.id.toString(), edtNoKtp.text, edtIdProfile.text, (result, error) {
        Navigator.of(context).pop();
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            _addCouple.sink.add(true);
          }else{
            _messageError.sink.add(result['message']);
          }
        }else{
          _messageError.sink.add(error['message']);
        }
      });
    }
  }

  confirmSpouse(BuildContext context, String reqId, String action) async {
    var user = await LocalData.getUser();
    if(user != null){
      Utils.progressDialog(context);
      API.confirmSpouse(user.id.toString(), reqId, action, (result, error) {
        Navigator.of(context).pop();
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            _confirmCouple.sink.add(true);
          }else{
            _messageError.sink.add(result['message']);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      });
    }
  }

  canAddSpouse() async{
    var user = await LocalData.getUser();
    if(user != null){
      if(user.gender == '1'){
        if(_totalPasangan < 2){
          _canAddCouple.sink.add(true);
        }else{
          _canAddCouple.sink.add(false);
        }
      }else{
        _canAddCouple.sink.add(false);
        // if(_totalPasangan < 1){
        //   _canAddCouple.sink.add(true);
        // }else{
        //   _canAddCouple.sink.add(false);
        // }
      }
    }
  }

  riwayatQuiz(BuildContext context) async{
    var user = await LocalData.getUser();
    if(user != null){
      Utils.progressDialog(context);
      API.riwayatQuiz(user.id.toString(), (result, error) {
        Navigator.of(context).pop();
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            var json = result as Map<String, dynamic>;
            var data = (json['data'] as List)?.map((e) => e == null ? null : RiwayatItem.fromJson(e as Map<String, dynamic>))?.toList();
            if(data != null){
              _dataRiwayat.sink.add(data);
            }
          }else{
            _messageError.sink.add(result['message']);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      });
    }
  }

  riwayatPasangan(String id) async{
    API.riwayatPasangan(id, (result, error) {
      // Navigator.of(context).pop();
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          var data = (json['data'] as List)?.map((e) => e == null ? null : PasanganItem.fromJson(e as Map<String, dynamic>))?.toList();
          if(data != null){
            _dataPasangan.sink.add(data);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(result['message']);
      }
    });
  }

  validasiPassword(BuildContext context){
    if(edtOldPass.text == ''){
      _messageError.sink.add('Kata Sandi Lama harus diisi!');
    }else if(edtNewPass.text == ''){
      _messageError.sink.add('Kata Sandi Baru harus diisi!');
    }else if(edtRePass.text == ''){
      _messageError.sink.add('Ulangi Kata Sandi Baru harus diisi!');
    }else if(edtOldPass.text.length < 4){
      _messageError.sink.add('Kata Sandi Lama minimal 4 digit!');
    }else if(edtNewPass.text.length < 4){
      _messageError.sink.add('Kata Sandi Baru minimal 4 digit!');
    }else if(edtRePass.text.length < 4){
      _messageError.sink.add('Ulangi Kata Sandi Baru minimal 4 digit!');
    }else{
      changePassword(context);
    }
  }

  changePassword(BuildContext context) async{
    Utils.progressDialog(context);
    var user = await LocalData.getUser();
    if(user != null){
      API.changePassword(user.id.toString(), edtOldPass.text, edtNewPass.text, (result, error) {
        Navigator.of(context).pop();
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            var json = result as Map<String, dynamic>;
            edtOldPass.text = '';
            edtNewPass.text = '';
            edtRePass.text = '';
            _messageError.sink.add('Kata sandi berhasil dirubah!');
          }else{
            Utils.alertError(context, error['message'], () { });
          }
        }else{
          Utils.alertError(context, error['message'], () { });
          // _messageError.sink.add(result['message']);/
        }
      });
    }

  }
}