
import 'package:kua/api/api.dart';
import 'package:kua/util/local_data.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc{

  final _viewScreen = PublishSubject<int>();
  final _verifyOK = PublishSubject<bool>();
  final _messageVerify = PublishSubject<String>();
  final _messageError = PublishSubject<String>();

  Stream<int> get viewScreen => _viewScreen.stream;
  Stream<bool> get verifyOK => _verifyOK.stream;
  Stream<String> get messageVerify => _messageVerify.stream;
  Stream<String> get messageError => _messageError.stream;

  changeScreen(int view){
    _viewScreen.sink.add(view);
  }

  checkVerify() async{
    var user = await LocalData.getUser();
    API.checkVerifyAccount(user.id.toString(), (result, error) {
      if(result != null){
        if(result['code'] == 200 && !result['error']){
          _verifyOK.sink.add(false);
        }else{
          _verifyOK.sink.add(false);
          _messageVerify.sink.add(result['message']);
          // _messageError.sink.add(result['message']);
        }
      }else{
        _verifyOK.sink.add(false);
        _messageVerify.sink.add(error['message']);
        // _messageError.sink.add(error['message']);
      }
    });
  }

}