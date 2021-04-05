
import 'package:kua/model/akun/biodata/pending_item.dart';
import 'package:kua/model/akun/biodata/waiting_item.dart';
part 'all_waiting.g.dart';
class AllWaiting{
  AllWaiting(){}
  List<WaitingItem> waiting;
  List<PendingItem> pending;

  factory AllWaiting.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}