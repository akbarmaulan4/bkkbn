
part of 'all_item_finding.dart';
AllItemFinding _$fromJson(Map<String, dynamic> json) {
  return AllItemFinding()
    ..data =  (json['data'] as List)
        ?.map((e) =>
    e == null ? null : ItemFinding.fromJson(e as Map<String, dynamic>))?.toList()
  ;
}

Map<String, dynamic> _$toJson(AllItemFinding instance) =>
    <String, dynamic>{
      'data': instance.data
    };