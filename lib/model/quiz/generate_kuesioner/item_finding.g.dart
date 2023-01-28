part of 'item_finding.dart';
ItemFinding _$fromJson(Map<String, dynamic> json) {
  return ItemFinding()
    ..id = json['id'] as int
    ..nama = json['nama'] as String
  ;
}

Map<String, dynamic> _$toJson(ItemFinding instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama
    };