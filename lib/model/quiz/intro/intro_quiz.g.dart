part of 'intro_quiz.dart';
IntroQuiz _$fromJson(Map<String, dynamic> json) {
  return IntroQuiz()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..deskripsi = json['deskripsi'] as String
    ..image = json['image'] as String
  ;
}

Map<String, dynamic> _$toJson(IntroQuiz instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'deskripsi': instance.deskripsi,
      'image': instance.image
    };