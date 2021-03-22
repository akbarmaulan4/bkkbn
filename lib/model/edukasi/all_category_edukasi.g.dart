
part of 'all_category_edukasi.dart';
AllCategoryEdukasi _$fromJson(Map<String, dynamic> json) {
  return AllCategoryEdukasi()
    ..data =  (json['data'] as List)
        ?.map((e) =>
    e == null ? null : EdukasiItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
  ;
}

Map<String, dynamic> _$toJson(AllCategoryEdukasi instance) =>
    <String, dynamic>{
      'data': instance.data
    };