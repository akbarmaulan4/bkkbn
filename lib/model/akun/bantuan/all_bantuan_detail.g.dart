part of 'all_bantuan_detail.dart';
AllBantuanDetail _$fromJson(Map<String, dynamic> json) {
  return AllBantuanDetail()
    ..data =  (json['data'] as List)
        ?.map((e) =>
    e == null ? null : DetailBantuanModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
  ;
}

Map<String, dynamic> _$toJson(AllBantuanDetail instance) =>
    <String, dynamic>{
      'data': instance.data
    };