
import 'package:flutter/cupertino.dart';
import 'package:kua/api/api.dart';
import 'package:kua/model/home/additional.dart';
import 'package:kua/model/home/data_home.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/local_data.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc{

  final _viewScreen = PublishSubject<int>();
  final _verifyOK = PublishSubject<bool>();
  final _messageVerify = PublishSubject<String>();
  final _messageError = PublishSubject<String>();
  final _dataHome = PublishSubject<DataHome>();
  final _version = PublishSubject<String>();
  final _haveNotif = PublishSubject<bool>();
  final _haveChat = PublishSubject<bool>();

  Stream<int> get viewScreen => _viewScreen.stream;
  Stream<bool> get verifyOK => _verifyOK.stream;
  Stream<String> get messageVerify => _messageVerify.stream;
  Stream<String> get messageError => _messageError.stream;
  Stream<DataHome> get dataHome => _dataHome.stream;
  Stream<String> get version => _version.stream;
  Stream<bool> get haveNotif => _haveNotif.stream;
  Stream<bool> get haveChat => _haveChat.stream;

  checkChat() async {
    var haveChat = await LocalData.getChat();
    if(haveChat != null){
      _haveChat.sink.add(haveChat);
    }else{
      _haveChat.sink.add(false);
    }

  }

  checkNotif() async {
    var haveNotif = await LocalData.getNotif();
    if(haveNotif != null){
      _haveNotif.sink.add(haveNotif);
    }else{
      _haveNotif.sink.add(false);
    }

  }

  setIndicatorChat(bool val){
    _haveChat.sink.add(val);
  }

  setIndicatorNotif(bool val){
    _haveNotif.sink.add(val);
  }

  changeScreen(int view){
    _viewScreen.sink.add(view);
  }

  bool _verifikasi = false;
  bool get verifikasi => _verifikasi;
  checkVerify() async{
    var user = await LocalData.getUser();
    API.checkVerifyAccount(user.id.toString(), (result, error) {
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          _verifikasi = true;
          _verifyOK.sink.add(true);
        }else{
          _verifyOK.sink.add(false);
          _messageVerify.sink.add(result['message']);
          // _messageError.sink.add(result['message']);
        }
      }else{
        _verifyOK.sink.add(false);
        _messageVerify.sink.add(error['message']);
        // _messageError.sink.add(error['message']);
      }
    });
  }

  home(BuildContext context) async{
    // Utils.progressDialog(context);
    var user = await LocalData.getUser();
    API.home(user.id.toString(), (result, error) {
      // Navigator.of(context).pop();
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          var data = DataHome.fromJson(json['data']);
          if(data != null){
            _dataHome.sink.add(data);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  resendVerification(BuildContext context, String url, List<Additional> params) async{
    Utils.progressDialog(context);
    API.resendVerificaion(url, params, (result, error) {
      Navigator.of(context).pop();
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          _messageError.sink.add(result['message']);
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }



  checkVersion(BuildContext context){
    // Utils.progressDialog(context);
    API.checkVersion((result, error) {
      Navigator.of(context).pop();
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var data = result['data'];
          _version.sink.add(result['message']);
        }else{
          _messageError.sink.add(error['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  inboxNotif() async {
    var user = await LocalData.getUser();
    if(user != null){
      API.inboxNotif(user.id.toString(), (result, error) {
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            var data = result['data']['status'];
            if(data == 1){
              setIndicatorChat(true);
              LocalData.haveChat(true);
            }else{
              setIndicatorChat(false);
            }
          }
        }
      });
    }

  }

}