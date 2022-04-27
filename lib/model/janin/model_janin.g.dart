part of 'model_janin.dart';
ModelJanin _$fromJson(Map<String, dynamic> json) {
  return ModelJanin()
    ..id = json['id'] as int ?? -1
    ..name = json['name'] as String ?? ''
    ..status = json['status'] as String ?? ''
    ..hpl = json['hpl'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(ModelJanin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'hpl': instance.hpl,
    };