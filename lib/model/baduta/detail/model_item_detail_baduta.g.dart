part of 'model_item_detail_baduta.dart';
ModelItemDetailBaduta _$fromJson(Map<String, dynamic> json) {
  return ModelItemDetailBaduta()
    ..label = json['label'] as String
    ..value = json['value'] as String
    ..color = json['color'] as String
  ;
}

Map<String, dynamic> _$toJson(ModelItemDetailBaduta instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'color': instance.color,
    };