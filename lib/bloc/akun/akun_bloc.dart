
import 'package:kua/api/api.dart';
import 'package:kua/model/akun/bantuan/all_bantuan.dart';
import 'package:kua/model/akun/bantuan/all_bantuan_detail.dart';
import 'package:kua/model/akun/bantuan/bantuan_item.dart';
import 'package:kua/model/akun/bantuan/detail_bantuan_model.dart';
import 'package:rxdart/rxdart.dart';

class AkunBloc{
  final _messageError = PublishSubject<String>();
  final _dataBantuan = PublishSubject<List<BantuanItem>>();
  final _detailBantuan = PublishSubject<DetailBantuanModel>();

  Stream<List<BantuanItem>> get dataBantuan => _dataBantuan.stream;
  Stream<String> get messageError => _messageError.stream;
  Stream<DetailBantuanModel> get detailBantuan => _detailBantuan.stream;

  bantuan(){
    API.bantuan((result, error) {
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

  getDetailBantuan(String id){
    API.detailBantuan(id, (result, error) {
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
}