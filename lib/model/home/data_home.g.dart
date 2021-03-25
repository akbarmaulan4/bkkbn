part of 'data_home.dart';
DataHome _$fromJson(Map<String, dynamic> json) {
  return DataHome()
    ..own = json["own"] == null ? null : Own.fromJson(json["own"] as Map<String, dynamic>)
    ..couple = (json['couple'] as List)?.map((e) => e == null ? null : Own.fromJson(e as Map<String, dynamic>))?.toList()
    ..result = (json['result'] as List)?.map((e) => e == null ? null : ItemResult.fromJson(e as Map<String, dynamic>))?.toList()
    ..info = (json['info'] as List)?.map((e) => e == null ? null : ItemInfo.fromJson(e as Map<String, dynamic>))?.toList()
    ..edukasi = (json['edukasi'] as List)?.map((e) => e == null ? null : ItemEdukasi.fromJson(e as Map<String, dynamic>))?.toList()
  ;
}

Map<String, dynamic> _$toJson(DataHome instance) =>
    <String, dynamic>{
      'own': instance.own,
      'couple': instance.couple,
      'result': instance.result,
      'info': instance.info,
      'edukasi': instance.edukasi,
    };