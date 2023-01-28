import 'package:flutter/cupertino.dart';
import 'package:kua/api/api.dart';
import 'package:kua/model/notif/item_notif.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/local_data.dart';
import 'package:rxdart/rxdart.dart';

class NotifBloc{

  final _messageError = PublishSubject<String>();
  final _dataNotif = PublishSubject<List<ItemNotif?>>();
  final _delete = PublishSubject<bool>();

  Stream<String> get messageError => _messageError.stream;
  Stream<List<ItemNotif?>> get dataNotif => _dataNotif.stream;
  Stream<bool> get delete => _delete.stream;

  listNotif() async {
    var user = await LocalData.getUser();
    API.listNotif(user.id.toString(), (result, error) {
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          var data = (json['data'] as List).map((e) => e == null ? null : ItemNotif.fromJson(e as Map<String, dynamic>)).toList();
          if(data != null){
            _dataNotif.sink.add(data);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  deleteNotif(BuildContext context) async {
    Utils.progressDialog(context);
    var user = await LocalData.getUser();
    API.deletetNotif(user.id.toString(), (result, error) {
      Navigator.of(context).pop();
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          _delete.sink.add(true);
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }
}