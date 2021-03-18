import 'package:rxdart/rxdart.dart';

class BeritaBloc{

  final _messageError = PublishSubject<String>();
  Stream<String> get messageError => _messageError.stream;
}