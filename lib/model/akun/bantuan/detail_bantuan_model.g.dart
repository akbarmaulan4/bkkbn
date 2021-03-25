part of 'detail_bantuan_model.dart';
DetailBantuanModel _$fromJson(Map<String, dynamic> json) {
  return DetailBantuanModel()
    ..id = json['id'] as int ?? -1
    ..title = json['title'] as String ?? ''
    ..content = json['content'] as String ?? ''
    ..image = json['image'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(DetailBantuanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image
    };