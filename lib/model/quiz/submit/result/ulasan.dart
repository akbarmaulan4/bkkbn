part 'ulasan.g.dart';
class Ulasan{
  Ulasan(){}
  String? komentar;
  String? name;
  String? jabatan;
  String? tanggal_ulasan;

  factory Ulasan.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}