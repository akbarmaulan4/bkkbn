part of 'edukasi_item.dart';
EdukasiItem _$fromJson(Map<String, dynamic> json) {
  return EdukasiItem()
    ..id = json['id'] as int ?? -1
    ..kategori = json['kategori'] as String ?? ''
    ..image = json['image'] as String ?? ''
    ..background = json['background'] as String ?? ''
    ..deskripsi = json['deskripsi'] as String ?? ''
    ..created_at = json['created_at'] as String ?? ''
    ..creator = json['creator'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(EdukasiItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kategori': instance.kategori,
      'image': instance.image,
      'background': instance.background,
      'deskripsi': instance.deskripsi,
      'created_at': instance.created_at,
      'creator': instance.creator
    };