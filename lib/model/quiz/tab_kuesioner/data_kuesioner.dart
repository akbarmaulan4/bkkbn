part 'data_kuesioner.g.dart';
class DataKuesioner{
  DataKuesioner(){}
  int? id;
  String? title;
  String? created_at;
  String? thumbnail;
  String? rating;
  String? background;
  String? action;
  int? total_pertanyaan;
  int? answered;
  int? ulasan;
  int? result_id;

  factory DataKuesioner.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}