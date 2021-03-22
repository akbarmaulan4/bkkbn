import 'package:flutter/cupertino.dart';
import 'package:kua/api/api.dart';
import 'package:kua/model/quiz/generate_kuesioner/all_item_finding.dart';
import 'package:kua/model/quiz/generate_kuesioner/group_question.dart';
import 'package:kua/model/quiz/generate_kuesioner/item_finding.dart';
import 'package:kua/model/quiz/generate_kuesioner/list_group_question.dart';
import 'package:kua/model/quiz/generate_kuesioner/pertanyaan.dart';
import 'package:kua/model/quiz/intro/intro_quiz.dart';
import 'package:kua/model/quiz/submit/group_quiz_submit.dart';
import 'package:kua/model/quiz/submit/pertanyaan_submit.dart';
import 'package:kua/model/quiz/submit/result/result_submit.dart';
import 'package:kua/model/quiz/tab_kuesioner/all_result_quiz.dart';
import 'package:kua/model/quiz/tab_kuesioner/data_kuesioner.dart';
import 'package:kua/util/local_data.dart';
import 'package:rxdart/rxdart.dart';

class QuizBloc {

  final _messageError = PublishSubject<String>();
  final _dataListKuesioner = PublishSubject<List<DataKuesioner>>();
  final _introQuiz = PublishSubject<IntroQuiz>();
  final _dataGroupQuestion = PublishSubject<List<GroupQuestion>>();
  final _heightWidget = PublishSubject<double>();
  final _dataFinding = PublishSubject<List<ItemFinding>>();
  final _resultSubmit = PublishSubject<ResultSubmit>();
  final _infoMaxLenght = PublishSubject<bool>();

  Stream<String> get messageError => _messageError.stream;
  Stream<List<DataKuesioner>> get dataListKuesioner => _dataListKuesioner.stream;
  Stream<IntroQuiz> get introQuiz => _introQuiz.stream;
  Stream<List<GroupQuestion>> get dataGroupQuestion => _dataGroupQuestion.stream;
  Stream<double> get heightWidget => _heightWidget.stream;
  Stream<List<ItemFinding>> get dataFinding => _dataFinding.stream;
  Stream<ResultSubmit> get resultSubmit => _resultSubmit.stream;
  Stream<bool> get infoMaxLenght => _infoMaxLenght.stream;

  double _heightW = 0.0;
  double get heightW => _heightW;

  setHeightWidget(double val){
    _heightWidget.sink.add(val);
    _heightW = val;
  }

  quizList(){
    API.quizList((result, error) {
      if(result != null){
        if(result['code'] == 200){
          if(result['error'] == true){
            _messageError.sink.add(result['message']);
          }else{
            var json = result as Map<String, dynamic>;
            var data = AllResultQuiz.fromJson(json);
            if(data != null){
              _dataListKuesioner.sink.add(data.data);
            }
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  quizIntro(int id){
    API.quizIntro(id, (result, error) {
      if(result != null){
        if(result['code'] == 200){
          if(result['error'] == true){
            _messageError.sink.add(result['message']);
          }else{
            var json = result as Map<String, dynamic>;
            var data = IntroQuiz.fromJson(json['data']);
            if(data != null){
              _introQuiz.sink.add(data);
            }
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  List<GroupQuestion> _dataGroup = [];
  List<GroupQuestion> get dataGroup => _dataGroup;
  changeDataGroup(List<GroupQuestion> val){
    _dataGroup = val;
  }

  listPertanyaanQuiz(int id){
    API.listPertanyaanQuiz(id, (result, error) {
      if(result != null){
        if(result['code'] == 200){
          if(result['error'] == true){
            _messageError.sink.add(result['message']);
          }else{
            var json = result as Map<String, dynamic>;
            var data = ListGroupQuestion.fromJson(json);
            if(data != null){
              _dataGroupQuestion.sink.add(data.data);
              _dataGroup.addAll(data.data);
            }
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  finding(String url, String param, String value){
    _infoMaxLenght.sink.add(false);
    API.finding(url, param, value, (result, error) {
      if(result != null){
        if(result['code'] == 200){
          var json = result as Map<String, dynamic>;
          var data = AllItemFinding.fromJson(json);
          if(data != null){
            _dataFinding.sink.add(data.data);
          }
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  showInfoMaxLeght(bool val){
    _infoMaxLenght.sink.add(val);
  }


  submitQuiz() async{
    List<GroupQuizSubmit> dataGroup2 = [];
    for(GroupQuestion group in  dataGroup){
      GroupQuizSubmit groupSubmit = new GroupQuizSubmit();
      groupSubmit.kuis_id = group.kuis_id;
      groupSubmit.header_id = group.header_id;
      groupSubmit.jenis = group.jenis;
      groupSubmit.pertanyaan = getPertanyaan(group.pertanyaan);
      dataGroup2.add(groupSubmit);
    }
    var user = await LocalData.getUser();
    API.submitQuiz(user.id.toString(), dataGroup2, (result, error) {
      if(result != null){
        if(result['code'] == 200){
          var json = result as Map<String, dynamic>;
          var data = ResultSubmit.fromJson(json['data']);
          _resultSubmit.sink.add(data);
        }else{
          _messageError.sink.add(result['message']);
        }
      }else{
        _messageError.sink.add(error['message']);
      }
    });
  }

  getPertanyaan(List<Pertanyaan> data){
    List<PertanyaanSubmit> dataSubmit = [];
    for(Pertanyaan tanya in data){
      PertanyaanSubmit submit = new PertanyaanSubmit();
      submit.kuis_id = tanya.kuis_id;
      submit.header_id = tanya.header_id;
      submit.pertanyaan_id = tanya.pertanyaan_id;
      submit.tipe = tanya.tipe;
      submit.value = tanya.value;
      submit.file_name = tanya.file_name;
      dataSubmit.add(submit);
    }
    return dataSubmit;
  }

}