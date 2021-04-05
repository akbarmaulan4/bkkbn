part of 'all_waiting.dart';
AllWaiting _$fromJson(Map<String, dynamic> json) {
  return AllWaiting()
    ..waiting =  (json['waiting'] as List)
        ?.map((e) =>
    e == null ? null : WaitingItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..pending =  (json['pending'] as List)
        ?.map((e) =>
    e == null ? null : PendingItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
  ;
}

Map<String, dynamic> _$toJson(AllWaiting instance) =>
    <String, dynamic>{
      'pending': instance.pending,
      'waiting': instance.waiting
    };