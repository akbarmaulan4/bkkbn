
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kua/api/api.dart';
import 'package:kua/model/baduta/anak/model_item_anak.dart';
import 'package:kua/model/baduta/riwayat/model_riwayat_baduta.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/local_data.dart';
import 'package:rxdart/rxdart.dart';

class BadutaController{

  final _messageError = PublishSubject<String>();
  final _baduta = PublishSubject<bool>();
  final _dataAnak = PublishSubject<List<ModelItemAnak?>>();
  final _detailRiwayat = PublishSubject<ModelRiwayatBaduta>();

  Stream<String> get messageError => _messageError.stream;
  Stream<bool> get baduta => _baduta.stream;
  Stream<List<ModelItemAnak?>> get dataAnak => _dataAnak.stream;
  Stream<ModelRiwayatBaduta> get detailRiwayat => _detailRiwayat.stream;



  getStatusBaduta(BuildContext context) async {
    Utils.progressDialog(context);
    var user = await LocalData.getUser();
    if(user != null){
      API.getStatusBaduta(user.id!, (result, error) {
        Navigator.of(context).pop();
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            var data = result['data'];
            if(data == '1'){
              _baduta.sink.add(true);
            }else{
              _baduta.sink.add(false);
            }
          }else{
            _baduta.sink.add(false);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      });
    }
  }

  updateStatusBaduta(BuildContext context) async {
    // Utils.progressDialog(context);
    var user = await LocalData.getUser();
    if(user != null){
      API.updateStatusBaduta(user.id.toString(), (result, error) {
        // Navigator.of(context).pop();
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            _baduta.sink.add(true);
          }else{
            _messageError.sink.add(result['message']);
          }
        }
      });
    }
  }

  listAnak() async {
    var user = await LocalData.getUser();
    if(user != null){
      API.listAnak(user.id.toString(), (result, error) {
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            List<ModelItemAnak?>? dataJanin = (result['data'] as List).map((e) => e == null ? null : ModelItemAnak.fromJson(e as Map<String, dynamic>)).toList();
            // List<ModelItemAnak> dataJanin = (result['data'] as List)?.map((e) => e == null ? null : ModelItemAnak.fromJson(e as Map<String, dynamic>))?.toList();
            if(dataJanin.length > 0){
              _dataAnak.sink.add(dataJanin);
            }else{
              _dataAnak.sink.add(dataJanin);
            }
          }
        }
      });
    }
  }

  resultQuizBaduta(String badutaID) async {
    var user = await LocalData.getUser();
    if(user != null){
      API.resultQuizBaduta(user.id.toString(), badutaID, (result, error) {
        if(result != null){
          var das = jsonEncode(result);
          if(result['code'] == 200 && !result['error']){
            ModelRiwayatBaduta baduta = ModelRiwayatBaduta.fromJson(result['data']);
            if(baduta != null){
              _detailRiwayat.sink.add(baduta);
            }
          }
        }
      });
    }
  }
}