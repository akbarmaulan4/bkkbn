part of 'group_question.dart';
GroupQuestion _$fromJson(Map<String, dynamic> json) {
  return GroupQuestion()
    ..kuis_id = json['kuis_id'] as String
    ..header_id = json['header_id'] as String
    ..jenis = json['jenis'] as String
    ..deskripsi = json['deskripsi'] as String
    ..caption = json['caption'] as String
    ..pertanyaan =  (json['pertanyaan'] as List)
        .map((e) =>
    e == null ? null : Pertanyaan.fromJson(e as Map<String, dynamic>)).cast<Pertanyaan>()
        .toList()
  ;
}

Map<String, dynamic> _$toJson(GroupQuestion instance) =>
    <String, dynamic>{
      'kuis_id': instance.kuis_id,
      'header_id': instance.header_id,
      'jenis': instance.jenis,
      'deskripsi': instance.deskripsi,
      'caption': instance.caption,
      'pertanyaan': instance.pertanyaan
    };