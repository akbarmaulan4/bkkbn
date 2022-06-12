part of 'model_item_anak.dart';
ModelItemAnak _$fromJson(Map<String, dynamic> json) {
  return ModelItemAnak()
    ..id = json['id'] as int ?? -1
    ..nama = json['nama'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(ModelItemAnak instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };