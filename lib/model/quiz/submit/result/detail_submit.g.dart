part of 'detail_submit.dart';
DetailSubmit _$fromJson(Map<String, dynamic> json) {
  return DetailSubmit()
    ..caption = json['caption'] as String
    ..label = json['label'] as String
    ..value = json['value'] as String
    ..rating = json['rating'] as String
    ..rating_color = json['rating_color'] as String
    ..file = (json['file'] as List)
        .map((e) => e == null ? null : FileDetailSubmit.fromJson(e as Map<String, dynamic>)).cast<FileDetailSubmit>()
        .toList()
  ;
}

Map<String, dynamic> _$toJson(DetailSubmit instance) =>
    <String, dynamic>{
      'caption': instance.caption,
      'label': instance.label,
      'value': instance.value,
      'rating': instance.rating,
      'rating_color': instance.rating_color,
      'file': instance.file,
    };