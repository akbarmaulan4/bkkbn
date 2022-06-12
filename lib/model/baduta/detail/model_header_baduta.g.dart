part of 'model_header_baduta.dart';
ModelHeaderBaduta _$fromJson(Map<String, dynamic> json) {
  return ModelHeaderBaduta()
    ..tanggal_kunjungan_petugas = json['tanggal_kunjungan_petugas'] as String ?? ''
    ..nama_baduta = json['nama_baduta'] as String ?? ''
    ..nama_ibu_baduta = json['nama_ibu_baduta'] as String ?? ''
    ..tanggal_lahir = json['tanggal_lahir'] as String ?? ''
    ..gender = json['gender'] as String ?? ''
    ..anak_ke = json['anak_ke'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(ModelHeaderBaduta instance) =>
    <String, dynamic>{
      'tanggal_kunjungan_petugas': instance.tanggal_kunjungan_petugas,
      'nama_baduta': instance.nama_baduta,
      'nama_ibu_baduta': instance.nama_ibu_baduta,
      'tanggal_lahir': instance.tanggal_lahir,
      'gender': instance.gender,
      'anak_ke': instance.anak_ke,
    };