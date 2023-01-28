part 'model_header_baduta.g.dart';
class ModelHeaderBaduta{
  ModelHeaderBaduta(){}
  String? tanggal_kunjungan_petugas;
  String? nama_baduta;
  String? nama_ibu_baduta;
  String? tanggal_lahir;
  String? gender;
  String? anak_ke;

  factory ModelHeaderBaduta.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}