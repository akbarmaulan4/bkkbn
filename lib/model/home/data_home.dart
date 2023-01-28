import 'package:kua/model/home/item_edukasi.dart';
import 'package:kua/model/home/item_info.dart';
import 'package:kua/model/home/item_result.dart';
import 'package:kua/model/home/own.dart';
import 'package:kua/model/home/quiz/item_summary_quiz.dart';
part 'data_home.g.dart';
class DataHome{
  DataHome(){}
  Own? own;
  List<Own>? couple;
  List<ItemResult>? result;
  List<ItemInfo>? info;
  List<ItemEdukasi>? edukasi;
  List<ItemSummaryQuiz>? summarykuis;

  factory DataHome.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}