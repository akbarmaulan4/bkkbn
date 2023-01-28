part of 'item_edukasi.dart';
ItemEdukasi _$fromJson(Map<String, dynamic> json) {
  return ItemEdukasi()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..image = json['image'] as String
    ..kategori = json['kategori'] as String
  ;
}

Map<String, dynamic> _$toJson(ItemEdukasi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'kategori': instance.kategori,
    };