import 'package:flutter/cupertino.dart';
import 'package:kua/api/api.dart';
import 'package:kua/model/edukasi/all_artikel.dart';
import 'package:kua/model/edukasi/all_category_edukasi.dart';
import 'package:kua/model/edukasi/artikel_item.dart';
import 'package:kua/model/edukasi/detail_edukasi.dart';
import 'package:kua/model/edukasi/edukasi_item.dart';
import 'package:kua/screen/home/edukasi/detail_artikel.dart';
import 'package:kua/util/Utils.dart';
import 'package:rxdart/rxdart.dart';

class EdukasiBloc{

  final _messageError = PublishSubject<String>();
  final _categoryEdukasi = PublishSubject<List<EdukasiItem>>();
  final _allArtikel = PublishSubject<List<ArtikelItem>>();
  final _detailEdukasi = PublishSubject<DetailEdukasi>();

  Stream<String> get messageError => _messageError.stream;
  Stream<List<EdukasiItem>> get categoryEdukasi => _categoryEdukasi.stream;
  Stream<List<ArtikelItem>> get allArtikel => _allArtikel.stream;
  Stream<DetailEdukasi> get detailEdukasi => _detailEdukasi.stream;


  newsCategory(BuildContext context) async{
    // Utils.progressDialog(context);
    API.newsCategory((result, error) {
      // Navigator.of(context).pop();
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          var data = AllCategoryEdukasi.fromJson(json);
          if(data != null){
            _categoryEdukasi.sink.add(data.data!);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  listArtikel(BuildContext context, String catId) async{
    Utils.progressDialog(context);
    API.listArtikel(catId, (result, error) {
      Navigator.of(context).pop();
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          var data = AllArtikel.fromJson(json);
          if(data != null){
            _allArtikel.sink.add(data.data!);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  getDetailArtikel(BuildContext context, String newsId) async{
    Utils.progressDialog(context);
    API.detailArtikel(newsId, (result, error) {
      Navigator.of(context).pop();
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          var data = DetailEdukasi.fromJson(json['data']);
          if(data != null){
            _detailEdukasi.sink.add(data);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  List<ArtikelItem> _allRelatedArticle = [];
  List<ArtikelItem> get allRelatedArticle => _allRelatedArticle;
  getRelatedlArtikel() async{
    API.relatedArtikel((result, error) {
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          var json = result as Map<String, dynamic>;
          var data = AllArtikel.fromJson(json);
          if(data != null){
            for(ArtikelItem item in data.data!){
              item.url = item.image;
            }
            _allRelatedArticle.addAll(data.data!);
            _allArtikel.sink.add(data.data!);
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