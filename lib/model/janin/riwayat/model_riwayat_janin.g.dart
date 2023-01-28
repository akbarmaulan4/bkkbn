part of 'model_riwayat_janin.dart';
ModelRiwayatJanin _$fromJson(Map<String, dynamic> json) {
  return ModelRiwayatJanin()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..details = (json['details'] as List).map((e) => e == null ? null :ModelItemRiwayat.fromJson(e as Map<String, dynamic>)).cast<ModelItemRiwayat>().toList()
      ;
}

Map<String, dynamic> _$toJson(ModelRiwayatJanin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'details': instance.details,
    };