part of 'model_detail_riwayat_janin.dart';
ModelDetailRiwayatJanin _$fromJson(Map<String, dynamic> json) {
  return ModelDetailRiwayatJanin()
    ..label = json['label'] as String
    ..details = (json['details'] as List).map((e) => e == null ? null :ModelItemRiwayatJanin.fromJson(e as Map<String, dynamic>)).cast<ModelItemRiwayatJanin>().toList()
  ;
}

Map<String, dynamic> _$toJson(ModelDetailRiwayatJanin instance) =>
    <String, dynamic>{
      'label': instance.label,
      'details': instance.details,
    };