import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kua/util/Utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class PdfBloc{
  final _fileFetcher = PublishSubject<File>();
  final _messageError = PublishSubject<String>();

  Stream<File> get fileFetcher => _fileFetcher.stream;
  Stream<String> get messageError => _messageError.stream;

  final _loadFetcher = PublishSubject<bool>();
  Stream<bool> get loadFetcher => _loadFetcher.stream;

  final _fileDoc = PublishSubject<File>();
  Stream<File> get fileDoc => _fileDoc.stream;

  File _dataFile = File('');
  File get dataFile => _dataFile;

  changeDoc(File val){
    if(val.existsSync()){
      _dataFile = val;
      _fileDoc.sink.add(val);
    }else{
      _dataFile = File('');
      _fileDoc.sink.add(File(''));
    }
  }

  donwloadFile(BuildContext context, String url, String fileName) async {
    try {

      /// getting application doc directory's path in dir variable
//      String dir = (await getApplicationDocumentsDirectory()).path;

    Utils.progressDialog(context);

    _loadFetcher.sink.add(true);
      String dir = (await getExternalStorageDirectory())!.path;
      print(dir);

      /// if `filename` File exists in local system then return that file.
      /// This is the fastest among all.
//      if (await File('$dir/$fileName').exists()){
//        _fileFetcher.sink.add(File('$dir/$fileName'));
//        return;
//      }

      ///if file not present in local system then fetch it from server
      var request = await HttpClient().getUrl(Uri.parse(url));

      /// closing request and getting response
      var response = await request.close();

      /// getting response data in bytes
      var bytes = await consolidateHttpClientResponseBytes(response);

      /// generating a local system file with name as 'filename' and path as '$dir/$filename'
      File file = new File('$dir/$fileName');

      /// writing bytes data of response in the file.
      await file.writeAsBytes(bytes);
      
      _fileFetcher.sink.add(file);
      _loadFetcher.sink.add(false);
      
      Navigator.of(context).pop();

    /// returning file.
//    return file;
    }

    /// on catching Exception return null
    catch (err) {
    print(err);
    Navigator.of(context).pop();
    Future.delayed(Duration(milliseconds: 100), () {
      _messageError.sink.add(err.toString());
    });
    return null;
    }
  }
}