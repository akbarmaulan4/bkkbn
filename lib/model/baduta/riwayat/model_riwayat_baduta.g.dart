part of 'model_riwayat_baduta.dart';
ModelRiwayatBaduta _$fromJson(Map<String, dynamic> json) {
  return ModelRiwayatBaduta()
    ..header = json["header"] == null ? null : ModelHeaderBaduta.fromJson(json["header"] as Map<String, dynamic>)
    ..details = (json['details'] as List).map((e) => e == null ? null : ModelDetailBaduta.fromJson(e as Map<String, dynamic>)).cast<ModelDetailBaduta>().toList()
    ..data_legends = json["data_legends"]
  ;
}

Map<String, dynamic> _$toJson(ModelRiwayatBaduta instance) =>
    <String, dynamic>{
      'header': instance.header,
      'details': instance.details,
      'data_legends': instance.data_legends,
    };