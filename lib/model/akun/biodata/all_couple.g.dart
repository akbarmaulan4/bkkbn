part of 'all_couple.dart';
AllCouple _$fromJson(Map<String, dynamic> json) {
  return AllCouple()
    ..data =  (json['data'] as List)
        .map((e) =>
    e == null ? null : CoupleItem.fromJson(e as Map<String, dynamic>)).cast<CoupleItem>()
        .toList()
  ;
}

Map<String, dynamic> _$toJson(AllCouple instance) =>
    <String, dynamic>{
      'data': instance.data
    };