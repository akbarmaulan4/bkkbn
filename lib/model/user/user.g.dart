part of 'user.dart';
UserModel _$fromJson(Map<String, dynamic> json) {
  return UserModel()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..no_telp = json['no_telp'] as String
    ..email = json['email'] as String
    ..email_verified_at = json['email_verified_at'] as String
    ..no_ktp = json['no_ktp'] as String
    ..foto_ktp = json['foto_ktp'] as String
    ..tempat_lahir = json['tempat_lahir'] as String
    ..tgl_lahir = json['tgl_lahir'] as String
    ..gender = json['gender'] as String
    ..alamat = json['alamat'] as String
    ..provinsi_id = json['provinsi_id'] as String
    ..kabupaten_id = json['kabupaten_id'] as String
    ..kecamatan_id = json['kecamatan_id'] as String
    ..kelurahan_id = json['kelurahan_id'] as String
    ..rt = json['rt'] as String
    ..rw = json['rw'] as String
    ..kodepos = json['kodepos'] as String
    ..is_active = json['is_active'] as String
  ;
}

Map<String, dynamic> _$toJson(UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'no_telp': instance.no_telp,
      'email': instance.email,
      'email_verified_at': instance.email_verified_at,
      'no_ktp': instance.no_ktp,
      'foto_ktp': instance.foto_ktp,
      'tempat_lahir': instance.tempat_lahir,
      'tgl_lahir': instance.tgl_lahir,
      'gender': instance.gender,
      'alamat': instance.alamat,
      'provinsi_id': instance.provinsi_id,
      'kabupaten_id': instance.kabupaten_id,
      'kecamatan_id': instance.kecamatan_id,
      'kelurahan_id': instance.kelurahan_id,
      'rt': instance.rt,
      'rw': instance.rw,
      'kodepos': instance.kodepos,
      'is_active': instance.is_active,
    };