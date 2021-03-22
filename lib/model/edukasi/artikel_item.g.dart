part of 'artikel_item.dart';
ArtikelItem _$fromJson(Map<String, dynamic> json) {
  return ArtikelItem()
    ..id = json['id'] as int ?? -1
    ..kategori = json['kategori'] as String ?? ''
    ..judul = json['judul'] as String ?? ''
    ..deskripsi = json['deskripsi'] as String ?? ''
    ..tgl_publish = json['tgl_publish'] as String ?? ''
    ..url = json['url'] as String ?? ''
    ..image = json['image'] as String ?? ''
    ..creator = json['creator'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(ArtikelItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kategori': instance.kategori,
      'judul': instance.judul,
      'deskripsi': instance.deskripsi,
      'tgl_publish': instance.tgl_publish,
      'url': instance.url,
      'image': instance.image,
      'creator': instance.creator
    };