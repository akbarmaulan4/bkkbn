
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kua/api/api.dart';
import 'package:kua/model/janin/model_janin.dart';
import 'package:kua/model/janin/riwayat/model_detail_riwayat_janin.dart';
import 'package:kua/model/janin/riwayat/model_riwayat_janin.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/local_data.dart';
import 'package:rxdart/rxdart.dart';

class HamilController{

  final _messageError = PublishSubject<String>();
  final _hamil = PublishSubject<bool>();
  final _dataJanin = PublishSubject<List<ModelJanin>>();
  final _dataRiwayatJanin = PublishSubject<List<ModelRiwayatJanin>>();
  final _dataDetailRiwayatJanin = PublishSubject<List<ModelDetailRiwayatJanin>>();

  Stream<String> get messageError => _messageError.stream;
  Stream<bool> get hamil => _hamil.stream;
  Stream<List<ModelJanin>> get dataJanin => _dataJanin.stream;
  Stream<List<ModelRiwayatJanin>> get dataRiwayatJanin => _dataRiwayatJanin.stream;
  Stream<List<ModelDetailRiwayatJanin>> get dataDetailRiwayatJanin => _dataDetailRiwayatJanin.stream;

  getStatusHamil(BuildContext context) async {
    Utils.progressDialog(context);
    var user = await LocalData.getUser();
    if(user != null){
      API.getStatusHamil(user.id, (result, error) {
        Navigator.of(context).pop();
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            var data = result['data'];
            if(data == '1'){
              _hamil.sink.add(true);
            }else{
              _hamil.sink.add(false);
            }
          }else{
            _hamil.sink.add(false);
          }
        }
      });
    }
  }

  updateStatusHamil(BuildContext context) async {
    // Utils.progressDialog(context);
    var user = await LocalData.getUser();
    if(user != null){
      API.updateStatusHamil(user.id.toString(), (result, error) {
        // Navigator.of(context).pop();
        if(result != null){
          if(result['code'] == 200 && !result['error']){
            _hamil.sink.add(true);
            // var data = result['data'];
            // if(data == '1'){
            //   _hamil.sink.add(true);
            // }else{
            //   _hamil.sink.add(false);
            // }
          }else{
            _messageError.sink.add(result['message']);
          }
        }
      });
    }
  }

  listJanin() async {
    var user = await LocalData.getUser();
    if(user != null){
      API.listJanin(user.id.toString(), (result, error) {
        if(result != null){
          var das = jsonEncode(result);
          if(result['code'] == 200 && !result['error']){
            List<ModelJanin> dataJanin = (result['data'] as List)?.map((e) => e == null ? null : ModelJanin.fromJson(e as Map<String, dynamic>))?.toList();
            if(dataJanin.length > 0){
              _dataJanin.sink.add(dataJanin);
            }else{
              _dataJanin.sink.add(dataJanin);
            }
          }
        }
      });
    }

  }

  riwayatJanin(int idJanin) async {
    var user = await LocalData.getUser();
    if(user != null){
      API.resultQuizHamil(user.id.toString(), idJanin.toString(), (result, error) {
        if(result != null){
          var das = jsonEncode(result);
          if(result['code'] == 200 && !result['error']){
            List<ModelRiwayatJanin> riwayat = (result['data'] as List)?.map((e) => e == null ? null : ModelRiwayatJanin.fromJson(e as Map<String, dynamic>))?.toList();
            if(riwayat.length > 0){
              _dataRiwayatJanin.sink.add(riwayat);
            }
          }
        }
      });
    }
  }

  getDetailRiwayatJanin(int idJanin, int quizId) async {
    var user = await LocalData.getUser();
    if (user != null) {
      API.resultDetailQuizHamil(user.id.toString(), idJanin.toString(), quizId.toString(), (result, error) {
        if (result != null) {
          var das = jsonEncode(result);
          if(result['code'] == 200 && !result['error']){
            List<ModelDetailRiwayatJanin> riwayat = (result['data'] as List)?.map((e) => e == null ? null : ModelDetailRiwayatJanin.fromJson(e as Map<String, dynamic>))?.toList();
            if(riwayat.length > 0){
              _dataDetailRiwayatJanin.sink.add(riwayat);
            }
          }
        }
      });
    }
  }
}