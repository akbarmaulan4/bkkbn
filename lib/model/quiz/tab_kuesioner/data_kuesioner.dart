part 'data_kuesioner.g.dart';
class DataKuesioner{
  DataKuesioner(){}
  int id;
  String title;
  String created_at;

  factory DataKuesioner.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}