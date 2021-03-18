
import 'package:kua/model/quiz/generate_kuesioner/item_finding.dart';
part 'all_item_finding.g.dart';
class AllItemFinding{
  AllItemFinding(){}
  List<ItemFinding> data;

  factory AllItemFinding.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}