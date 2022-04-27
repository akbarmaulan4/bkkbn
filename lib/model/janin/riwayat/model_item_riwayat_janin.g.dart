part of 'model_item_riwayat_janin.dart';
ModelItemRiwayatJanin _$fromJson(Map<String, dynamic> json) {
  return ModelItemRiwayatJanin()
    ..label = json['label'] as String ?? ''
    ..value = json['value'] as String ?? '';
}

Map<String, dynamic> _$toJson(ModelItemRiwayatJanin instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value
    };