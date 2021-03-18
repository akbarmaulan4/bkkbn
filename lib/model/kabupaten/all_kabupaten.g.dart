
part of 'all_kabupaten.dart';

AllKabupaten _$fromJson(Map<String, dynamic> json) {
  return AllKabupaten()
    ..data =  (json['data'] as List)
        ?.map((e) =>
    e == null ? null : DataKabupaten.fromJson(e as Map<String, dynamic>))
        ?.toList()
  ;
}

Map<String, dynamic> _$toJson(AllKabupaten instance) =>
    <String, dynamic>{
      'data': instance.data
    };