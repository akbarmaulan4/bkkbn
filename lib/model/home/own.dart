part 'own.g.dart';
class Own{
  Own(){}
  int id;
  String name;
  String tgl_lahir;
  String profile_id;
  String pic;
  String kota;

  factory Own.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}