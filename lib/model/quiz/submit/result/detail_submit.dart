import 'package:kua/model/quiz/submit/result/file_detail_submit.dart';

part 'detail_submit.g.dart';
class DetailSubmit{
  DetailSubmit(){}
  String caption;
  String label;
  String value;
  String rating;
  String rating_color;
  List<FileDetailSubmit> file;

  factory DetailSubmit.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}