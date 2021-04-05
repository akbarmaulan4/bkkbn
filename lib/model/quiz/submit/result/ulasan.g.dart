part of 'ulasan.dart';
Ulasan _$fromJson(Map<String, dynamic> json) {
  return Ulasan()
    ..komentar = json['komentar'] as String ?? ''
    ..name = json['name'] as String ?? ''
    ..jabatan = json['jabatan'] as String ?? ''
    ..tanggal_ulasan = json['tanggal_ulasan'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(Ulasan instance) =>
    <String, dynamic>{
      'komentar': instance.komentar,
      'name': instance.name,
      'jabatan': instance.jabatan,
      'tanggal_ulasan': instance.tanggal_ulasan,
    };