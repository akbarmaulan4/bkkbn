
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class BlocChat {
  final _getMessage = PublishSubject<String>();
  final _allMessage = PublishSubject<List<String>>();

  Stream<String> get getMessage => _getMessage.stream;
  Stream<List<String>> get allMessage => _allMessage.stream;

  List<String> _allMessageChat = [];
  List<String> get allMessageChat => _allMessageChat;

  TextEditingController edtMessage = new TextEditingController();

  postMessage(String message){
    _allMessageChat.add(message);
    _allMessage.sink.add(allMessageChat);
    edtMessage.text = '';
    Map data = Map();
    var dateTime = DateTime.now();
    var dateFormat = DateFormat("HH:mm");
    dateFormat.format(dateTime);
    data.putIfAbsent('message', () => message);
    data.putIfAbsent('time', () => dateFormat.toString());
  }
}