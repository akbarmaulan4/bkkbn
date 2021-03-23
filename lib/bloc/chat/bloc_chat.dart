
import 'package:rxdart/rxdart.dart';

class BlocChat {
  final _viewScreen = PublishSubject<int>();
  Stream<int> get viewScreen => _viewScreen.stream;
}