part 'user.g.dart';
class UserModel{
  UserModel(){}
  int id;
  String name;
  String no_telp;
  String email;
  String email_verified_at;
  String no_ktp;
  String foto_ktp;
  String tempat_lahir;
  String tgl_lahir;
  String gender;
  String alamat;
  String provinsi_id;
  String kabupaten_id;
  String kecamatan_id;
  String kelurahan_id;
  String rt;
  String rw;
  String kodepos;
  String is_active;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}