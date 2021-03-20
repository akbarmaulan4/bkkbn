import 'dart:convert';
import 'dart:io';
// import 'package:http/http.dart' as http;
import 'package:kua/util/Utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class API{
  static String BASE_URL = "http://bkkbn.backoffice.my.id/api/v1";
//  EnvironmentConfig.environment == Environment.development
//      ? "http://api-dev.kedai-sayur.com/kedaiemak-api/api/v1" //"""http://kei-dev.kedai-sayur.com:30517/kedaiemak-api/api/v1"
//      : EnvironmentConfig.environment == Environment.sandbox
//      ? "http://api-sandbox.kedai-sayur.com/kedaiemak-api/api/v1"//"http://api-sandbox.kedai-sayur.com/kedaiemak-api/api/v1"
//      : "http://api-ke.kedaisayur.com/kedaiemak-api/api/v1";

  static basePost(
      String module,
      Map<String, dynamic> post,
      Map<String, String> headers,
      bool encode,
      void callback(dynamic, Exception)) async {

    Utils.log("URL ${BASE_URL + module}");
    Utils.log("POST Header ${json.encode(headers)}");
    Utils.log("POST VALUE ${json.encode(post)}");

    var mapError = new Map();
    try{
      final response = await http.post(Uri.parse(BASE_URL + module),
          // ignore: missing_return
          headers: headers, body: encode ? json.encode(post) : post).timeout(Duration(seconds: 30), onTimeout: (){
        // callback(null, HTTPStatusFailedException('Koneksi terputus, silahkan coba lagi'));
        mapError.putIfAbsent('message', () => 'Koneksi terputus, silahkan coba lagi');
        callback(null, mapError);
      });
      if(response != null){
        int responseCode = response.statusCode;
        var mapJson = json.decode(response.body);
        Utils.log("POST RESULT ${json.encode(mapJson)}");
        if (mapJson['code'] == 200) {
          callback(mapJson, null);
        } else if (responseCode == 401 ||
            responseCode == 403 ||
            mapJson['code'] == 401 ||
            mapJson['code'] == 403) {
          callback(null, mapJson);
        } else {
          callback(null, mapJson);
        }
      }else{
        mapError.putIfAbsent('message', () => 'Koneksi sedang tidak stabil');
        callback(null, mapError);
      }
    } on SocketException catch(e){
      mapError.putIfAbsent('message', () => 'Koneksi sedang tidak stabil');
      callback(null, mapError);
    } catch (e){
      mapError.putIfAbsent('message', () => 'Koneksi sedang tidak stabil');
      callback(null, mapError);
    }
  }


  static basePost2(
      String url,
      Map<String, dynamic> post,
      Map<String, String> headers,
      bool encode,
      void callback(dynamic, Exception)) async {

    Utils.log("URL ${BASE_URL + url}");
    Utils.log("POST Header ${json.encode(headers)}");
    Utils.log("POST VALUE ${json.encode(post)}");

    var mapError = new Map();
    try{

      final response = await http.post( Uri.parse(url),
          // ignore: missing_return
          headers: headers, body: encode ? json.encode(post) : post).timeout(Duration(seconds: 30), onTimeout: (){
        // callback(null, HTTPStatusFailedException('Koneksi terputus, silahkan coba lagi'));
        mapError.putIfAbsent('message', () => 'Koneksi terputus, silahkan coba lagi');
        callback(null, mapError);
      });
      if(response != null){
        int responseCode = response.statusCode;
        var mapJson = json.decode(response.body);
        Utils.log("POST RESULT ${json.encode(mapJson)}");
        if (mapJson['code'] == 200) {
          callback(mapJson, null);
        } else if (responseCode == 401 ||
            responseCode == 403 ||
            mapJson['code'] == 401 ||
            mapJson['code'] == 403) {
          callback(null, mapJson);
        } else {
          callback(null, mapJson);
        }
      }else{
        mapError.putIfAbsent('message', () => 'Koneksi sedang tidak stabil');
        callback(null, mapError);
      }
    } on SocketException catch(e){
      mapError.putIfAbsent('message', () => 'Koneksi sedang tidak stabil');
      callback(null, mapError);
    } catch (e){
      mapError.putIfAbsent('message', () => 'Koneksi sedang tidak stabil');
      callback(null, mapError);
    }
  }

  static postLogin(String username, String pas, void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['username'] = username;
    post['password'] = pas;
    basePost('/login', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static postRegister(
      String name,
      String email,
      String password,
      String no_telp,
      String no_ktp,
      String foto_name,
      String foto_ktp,
      String tempat_lahir,
      String tgl_lahir,
      String gender,
      String alamat,
      String provinsi_id,
      String kabupaten_id,
      String kecamatan_id,
      String kelurahan_id,
      String rt,
      String rw,
      String kodepos,
      void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['name'] = name;
    post['no_telp'] = no_telp;
    post['email'] = email;
    post['password'] = password;
    post['no_ktp'] = no_ktp;
    post['foto_name'] = foto_name;
    post['foto_ktp'] = foto_ktp;
    post['tempat_lahir'] = tempat_lahir;
    post['tgl_lahir'] = tgl_lahir;
    post['gender'] = gender;
    post['alamat'] = alamat;
    post['provinsi_id'] = provinsi_id;
    post['kabupaten_id'] = kabupaten_id;
    post['kecamatan_id'] = kecamatan_id;
    post['kelurahan_id'] = kelurahan_id;
    post['rt'] = rt;
    post['rw'] = rw;
    post['kodepos'] = kodepos;
    basePost('/register', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static emailChecking(String email,  void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['email'] = email;
    basePost('/emailcheck', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static getProvinsi(void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    basePost('/provinsi', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static getKabupaten(String provinsiId, void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['provinsi_id'] = provinsiId;
    basePost('/kabupaten', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static getKecamatan(String kabId, void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['kabupaten_id'] = kabId;
    basePost('/kecamatan', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static getKelurahan(String kecId, void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['kecamatan_id'] = kecId;
    basePost('/kelurahan', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static forgotPassword(String email, void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['email'] = email;
    post['tipe'] = '2';
    basePost('/forgot', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static quizList(void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    basePost('/kuislist', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static quizIntro(int id, void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['id'] = id;
    basePost('/kuisintro', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static listPertanyaanQuiz(int id, void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['id'] = id;
    basePost('/pertanyaan', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static submitQuiz(String userId, List data, void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['user_id'] = userId;
    post['data'] = data;
    basePost('/submitkuis', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static checkVerifyAccount(String userId, void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['id'] = userId;
    basePost('/checkverify', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static finding(String url, String param, String valueParam, void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post[param] = valueParam;
    basePost2(url, post, header, true, (result, error){
      callback(result, error);
    });
  }

  static baseGetFile(String module,
      Map<String, String> headers,
      String namaFile,
      void callback(File file)) async {
    Utils.log("URL ${BASE_URL + module}");
    try {
      final response = await http.get(Uri.parse(BASE_URL + module), headers: headers);
      if (response.contentLength == 0){
        return callback(null);
      }
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file = new File('$tempPath/$namaFile');
      await file.writeAsBytes(response.bodyBytes);
      callback(file);
    } catch (e) {
      // callback(null, HTTPStatusFailedException('Koneksi sedang tidak stabil'));
    }
  }

  static baseGet(String module, Map<String, String> headers,
      void callback(dynamic, exception)) async {
    Utils.log("URL ${BASE_URL + module}");

    // var connect = await isConnected();
    // if(!connect){
    //   callback(null, 'Tidak ada koneksi');
    //   return;
    // }

    try {
      final response = await http.get(Uri.parse(BASE_URL + module), headers: headers);
      int responseCode = response.statusCode;
      var mapJson = json.decode(response.body);

      Utils.log("RESPONSE ${mapJson.toString()}");

      if (mapJson['code'] == 200) {
        callback(mapJson, null);
      } else if (responseCode == 401 ||
          responseCode == 403 ||
          mapJson['code'] == 401 ||
          mapJson['code'] == 403 || mapJson['code'] == 422) {
        // callback(null, TokenException());
      } else {
        // callback(null, HTTPStatusFailedException(mapJson['message']));
      }
    } catch (e) {
      // callback(null, HTTPStatusFailedException('Koneksi sedang tidak stabil'));
    }
  }

  static getUserProfile(void callback(Map, Exception)) {
    var header = new Map<String, String>();
    header['Content-Type'] = 'application/json';
    baseGet('/user', header, (result, error) {
      callback(result, error);
    });
  }



  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static baseDelete(String module, Map<String, String> headers,
      void callback(dynamic, exception)) async {
    Utils.log("URL ${BASE_URL + module}");
    Utils.log("Header ${json.encode(headers)}");
    // var connect = await isConnected();
    // if(!connect){
    //   callback(null, 'Tidak ada koneksi');
    //   return;
    // }

    try {
      final response = await http.delete(Uri.parse(BASE_URL + module), headers: headers);
      int responseCode = response.statusCode;
      var mapJson = json.decode(response.body);

      Utils.log("RESPONSE ${mapJson.toString()}");

      if (mapJson['code'] == 200) {
        callback(mapJson, null);
      } else if (responseCode == 401 ||
          responseCode == 403 ||
          mapJson['code'] == 401 ||
          mapJson['code'] == 403 ||
          mapJson['code'] == 422) {
        // callback(null, TokenException());
      } else {
        // callback(null, HTTPStatusFailedException(mapJson['message']));
      }
    } catch (e) {
      // callback(null, HTTPStatusFailedException('Koneksi sedang tidak stabil'));
    }
  }



  static basePut(
      String module,
      Map<String, dynamic> post,
      Map<String, String> headers,
      bool encode,
      void callback(dynamic, Exception)) async {

    Utils.log("URL ${BASE_URL + module}");
    Utils.log("POST Header ${json.encode(headers)}");
    Utils.log("POST VALUE ${json.encode(post)}");

    var mapError = new Map();
    try{
          final response = await http.put(Uri.parse(BASE_URL+module),
          // ignore: missing_return
          headers: headers, body: encode ? json.encode(post) : post).timeout(Duration(seconds: 30), onTimeout: (){
        // callback(null, HTTPStatusFailedException('Koneksi terputus, silahkan coba lagi'));
        mapError.putIfAbsent('message', () => 'Koneksi terputus, silahkan coba lagi');
        callback(null, mapError);
      });
      if(response != null){
        int responseCode = response.statusCode;
        var mapJson = json.decode(response.body);
        Utils.log("POST RESULT ${json.encode(mapJson)}");
        if (mapJson['code'] == 200) {
          callback(mapJson, null);
        } else if (responseCode == 401 ||
            responseCode == 403 ||
            mapJson['code'] == 401 ||
            mapJson['code'] == 403) {
          callback(null, mapJson);
        } else {
          callback(null, mapJson);
        }
      }else{
        mapError.putIfAbsent('message', () => 'Koneksi sedang tidak stabil');
        callback(null, mapError);
      }
    } on SocketException catch(e){
      mapError.putIfAbsent('message', () => 'Koneksi sedang tidak stabil');
      callback(null, mapError);
    } catch (e){
      mapError.putIfAbsent('message', () => 'Koneksi sedang tidak stabil');
      callback(null, mapError);
    }
  }
}