part of 'additional.dart';
Additional _$fromJson(Map<String, dynamic> json) {
  return Additional()
    ..params = json['params'] as String
    ..value = json['value'] as String
  ;
}

Map<String, dynamic> _$toJson(Additional instance) =>
    <String, dynamic>{
      'params': instance.params,
      'value': instance.value,
    };