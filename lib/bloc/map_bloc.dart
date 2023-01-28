
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc{

  final _messageError = PublishSubject<String>();
  final _currentAddress = PublishSubject<String>();
  final _currentAddressName = PublishSubject<String>();
  final _currentLatitude = PublishSubject<double>();
  final _currentLongitude = PublishSubject<double>();

  Stream<String> get messageError => _messageError.stream;
  Stream<String> get currentAddress => _currentAddress.stream;
  Stream<String> get currentAddressName => _currentAddressName.stream;
  Stream<double> get currentLatitude => _currentLatitude.stream;
  Stream<double> get currentLongitude => _currentLongitude.stream;

  TextEditingController edtSearch = TextEditingController();

  double _posLat = 0.0;
  double _posLon = 0.0;
  double get posLat => _posLat;
  double get posLon => _posLon;

  changeLatLon(double lat, double lon){
    _posLat = lat;
    _posLon = lon;
    _currentLatitude.sink.add(lat);
    _currentLongitude.sink.add(lon);
  }

  changeAddressName(String name, String str){
    _currentAddressName.sink.add(name);
    _currentAddress.sink.add(str);
  }

  changeAddress(CameraPosition cameraPosition) async{
    List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition.target.latitude, cameraPosition.target.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    changeLatLon(cameraPosition.target.latitude, cameraPosition.target.longitude);
    _currentAddress.sink.add('${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}');
    _currentAddressName.sink.add(place.name!);
  }
}