
part of 'all_kecamatan.dart';

AllKecamatan _$fromJson(Map<String, dynamic> json) {
  return AllKecamatan()
    ..data =  (json['data'] as List)
        ?.map((e) =>
    e == null ? null : DataKecamatan.fromJson(e as Map<String, dynamic>))
        ?.toList()
  ;
}

Map<String, dynamic> _$toJson(AllKecamatan instance) =>
    <String, dynamic>{
      'data': instance.data
    };