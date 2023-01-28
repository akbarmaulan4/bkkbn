part of 'model_item_riwayat.dart';
ModelItemRiwayat _$fromJson(Map<String, dynamic> json) {
  return ModelItemRiwayat()
    ..label = json['label'] as String
    ..value = json['value'].toString()
    ..color = json['color'] as String
    ..label_color = json['label_color'] as String
  ;
}

Map<String, dynamic> _$toJson(ModelItemRiwayat instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'color': instance.color,
      'label_color': instance.label_color,
    };