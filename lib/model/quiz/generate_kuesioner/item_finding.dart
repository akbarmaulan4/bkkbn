part 'item_finding.g.dart';

class ItemFinding{
  ItemFinding(){}
  int? id;
  String? nama;

  factory ItemFinding.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}