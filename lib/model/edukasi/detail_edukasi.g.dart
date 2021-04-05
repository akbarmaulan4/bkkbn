part of 'detail_edukasi.dart';
DetailEdukasi _$fromJson(Map<String, dynamic> json) {
  return DetailEdukasi()
    ..id = json['id'] as int ?? -1
    ..kategori = json['kategori'] as String ?? ''
    ..deskripsi = json['deskripsi'] as String ?? ''
    ..judul = json['judul'] as String ?? ''
    ..content = json['content'] as String ?? ''
    ..tgl_publish = json['tgl_publish'] as String ?? ''
    ..image = json['image'] as String ?? ''
    ..creator = json['creator'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(DetailEdukasi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kategori': instance.kategori,
      'judul': instance.judul,
      'deskripsi': instance.deskripsi,
      'content': instance.content,
      'tgl_publish': instance.tgl_publish,
      'image': instance.image,
      'creator': instance.creator
    };