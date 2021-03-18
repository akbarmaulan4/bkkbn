part 'file_detail_submit.g.dart';
class FileDetailSubmit{
  FileDetailSubmit(){}
  String name;
  String file;

  factory FileDetailSubmit.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}