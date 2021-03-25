part of 'all_bantuan.dart';
AllBantuan _$fromJson(Map<String, dynamic> json) {
  return AllBantuan()
    ..data =  (json['data'] as List)
        ?.map((e) =>
    e == null ? null : BantuanItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
  ;
}

Map<String, dynamic> _$toJson(AllBantuan instance) =>
    <String, dynamic>{
      'data': instance.data
    };