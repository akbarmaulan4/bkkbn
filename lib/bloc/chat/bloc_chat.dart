
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kua/api/api.dart';
import 'package:kua/model/chat/chat_item.dart';
import 'package:kua/model/chat/type_chat_model.dart';
import 'package:kua/util/local_data.dart';
import 'package:rxdart/rxdart.dart';

class BlocChat {
  final _getMessage = PublishSubject<String>();
  final _allMessage = PublishSubject<List<Map>>();
  final _messageError = PublishSubject<String>();
  final _allChat = PublishSubject<List<ChatItem?>>();
  final _typeChat = PublishSubject<List<TypeChatModel?>>();
  final _finishCat = PublishSubject<bool>();

  Stream<String> get getMessage => _getMessage.stream;
  Stream<List<Map>> get allMessage => _allMessage.stream;
  Stream<String> get messageError => _messageError.stream;
  Stream<List<ChatItem?>> get allChat => _allChat.stream;
  Stream<List<TypeChatModel?>> get typeChat => _typeChat.stream;
  Stream<bool> get finishCat => _finishCat.stream;

  List<Map> _allMessageChat = [];
  List<Map> get allMessageChat => _allMessageChat;

  TextEditingController edtMessage = new TextEditingController();

  postMessage(String message, String type) async{
    // Map data = Map();
    // var dateTime = DateTime.now();
    // var dateFormat = DateFormat("HH:mm");
    // var time = dateFormat.format(dateTime);
    // data.putIfAbsent('message', () => message);
    // data.putIfAbsent('time', () => time);
    // _allMessageChat.add(data);
    // _allMessage.sink.add(allMessageChat);
    // edtMessage.text = '';
    var user = await LocalData.getUser();
    if(user != null){
      _finishCat.sink.add(false);
      API.postChat(user.id.toString(), message, type, (result, error) {
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            var json = result as Map<String, dynamic>;
            edtMessage.text = '';
            getAllChat(type);
          }else{
            _messageError.sink.add(result['message']);
            // _finishCat.sink.add(true);
          }
        }else{
          _messageError.sink.add(error['message']);
          // _finishCat.sink.add(true);
        }
      });
    }
  }

  getAllChat(String type) async{
    _finishCat.sink.add(false);
    var user = await LocalData.getUser();
    if(user != null){
      API.listChat(user.id.toString(), type, (result, error) {
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            var json = result as Map<String, dynamic>;
            List<ChatItem?>? data = (json['data'] as List).map((e) => e == null ? null : ChatItem.fromJson(e as Map<String, dynamic>)).toList();
            if(data.length > 0){
              _allChat.sink.add(data);
            }
            _finishCat.sink.add(true);
          }else{
            _messageError.sink.add(result['message']);
          }
        }else{
          _messageError.sink.add(error['message']);
        }
      });
    }
  }

  getChatType() async{
    var dsada = await LocalData.getUser();
    API.getChatType(dsada.id!, (result, error) {
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          var data = (json['data'] as List).map((e) => e == null ? null : TypeChatModel.fromJson(e as Map<String, dynamic>)).toList();
          if(data != null){
            _typeChat.sink.add(data);
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