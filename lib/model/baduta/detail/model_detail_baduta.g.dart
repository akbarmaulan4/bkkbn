part of 'model_detail_baduta.dart';
ModelDetailBaduta _$fromJson(Map<String, dynamic> json) {
  return ModelDetailBaduta()
    ..label = json['label'] as String ?? ''
    ..details = (json['details'] as List)?.map((e) => e == null ? null : ModelItemDetailBaduta.fromJson(e as Map<String, dynamic>))?.toList();
  ;
}

Map<String, dynamic> _$toJson(ModelDetailBaduta instance) =>
    <String, dynamic>{
      'label': instance.label,
      'details': instance.details,
    };