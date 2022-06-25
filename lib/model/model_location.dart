import 'package:flutter/material.dart';

class ModelLocation{
  ModelLocation(){}
  String latitude;
  String longitude;

  factory ModelLocation.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}

ModelLocation _$fromJson(Map<String, dynamic> json) {
  return ModelLocation()
    ..latitude = json['latitude'] as String ?? ''
    ..longitude = json['longitude'] as String ?? ''
  ;
}

Map<String, dynamic> _$toJson(ModelLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };