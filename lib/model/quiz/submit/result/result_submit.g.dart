part of 'result_submit.dart';
ResultSubmit _$fromJson(Map<String, dynamic> json) {
  return ResultSubmit()
    ..header = json["header"] == null ? null : HeaderSubmit.fromJson(json["header"] as Map<String, dynamic>)
    ..detail = (json['detail'] as List)
        ?.map((e) => e == null ? null : DetailSubmit.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..ulasan = json["ulasan"] == null ? null : Ulasan.fromJson(json["ulasan"] as Map<String, dynamic>)
  ;
}

Map<String, dynamic> _$toJson(ResultSubmit instance) =>
    <String, dynamic>{
      'header': instance.header,
      'detail': instance.detail,
      'ulasan': instance.ulasan
    };