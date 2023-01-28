
part of 'all_provinsi.dart';

AllProvinsi _$fromJson(Map<String, dynamic> json) {
  return AllProvinsi()
    ..data =  (json['data'] as List)
        .map((e) =>
    e == null ? null : DataProvinsi.fromJson(e as Map<String, dynamic>)).cast<DataProvinsi>()
        .toList()
  ;
}

Map<String, dynamic> _$toJson(AllProvinsi instance) =>
    <String, dynamic>{
      'data': instance.data
    };