
import 'package:kua/model/quiz/submit/result/detail_submit.dart';
import 'package:kua/model/quiz/submit/result/header_submit.dart';
import 'package:kua/model/quiz/submit/result/ulasan.dart';
part 'result_submit.g.dart';
class ResultSubmit{
  ResultSubmit(){}
  HeaderSubmit header;
  List<DetailSubmit> detail;
  Ulasan ulasan;

  factory ResultSubmit.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}