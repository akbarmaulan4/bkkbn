part 'additional.g.dart';
class Additional{
  Additional(){}
  String params;
  String value;

  factory Additional.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}