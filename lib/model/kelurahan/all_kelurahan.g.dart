part of 'all_kelurahan.dart';

AllKelurahan _$fromJson(Map<String, dynamic> json) {
  return AllKelurahan()
    ..data =  (json['data'] as List)
        .map((e) =>
    e == null ? null : DataKelurahan.fromJson(e as Map<String, dynamic>)).cast<DataKelurahan>()
        .toList()
  ;
}

Map<String, dynamic> _$toJson(AllKelurahan instance) =>
    <String, dynamic>{
      'data': instance.data
    };