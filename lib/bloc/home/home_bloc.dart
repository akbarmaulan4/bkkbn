
import 'package:rxdart/rxdart.dart';

class HomeBloc{

  final _viewScreen = PublishSubject<int>();
  Stream<int> get viewScreen => _viewScreen.stream;

  changeScreen(int view){
    _viewScreen.sink.add(view);
  }


}