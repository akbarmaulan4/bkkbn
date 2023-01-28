import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:kua/bloc/auth/auth_bloc.dart';
import 'package:kua/bloc/map_bloc.dart';
import 'package:kua/model/model_location.dart';
import 'package:kua/screen/auth/maps/search_place.dart';
import 'package:kua/util/Utils.dart';
import 'package:kua/util/color_code.dart';
import 'package:kua/util/constant_style.dart';
import 'package:kua/util/image_constant.dart';
import 'package:kua/widgets/box_border.dart';
import 'package:kua/widgets/font/avenir_text.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? googleMapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.252300, 106.847336),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  //contrller for Google map
  CameraPosition? cameraPosition;
  MapBloc bloc = MapBloc();
  AuthBloc authBloc = AuthBloc();
  // MapController controller = MapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authBloc.getCurrentLocation();
    authBloc.currentLocation.listen((data) {
      if(data != null){
        cameraMove(CameraPosition(
            target: LatLng(data.latitude, data.longitude),
            zoom: 19.151926040649414
        ));
      }
    });
    // controller.getCurrenLocation();
    // getCurrenLocation();
    // controller.getCurrenLocation();
  }

  getCurrenLocation() async{
    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if(serviceEnabled){
    //
    // }
    // Position position = await Geolocator.getCurrentPosition();
    // if(position != null){
    //
    // }
    // Position position = await Geolocator.getCurrentPosition();
    // if(position != null){
    //   cameraMove(CameraPosition(
    //       target: LatLng(position.latitude, position.longitude),
    //       zoom: 19.151926040649414
    //   ));
    // }
    // Location location = Location();
    // LocationData _locationData = await location.getLocation();
    // cameraMove(CameraPosition(
    //   target: LatLng(_locationData.latitude, _locationData.longitude),
    //   zoom: 19.151926040649414
    // ));
  }

  showGoogleSearchPlace() async {
    // Prediction p = await PlacesAutocomplete.show(
    //     context: context,
    //     apiKey: 'AIzaSyDPq_TPd_Jdc_ktaLzFIU2e30GoF11yBvc',
    //     mode: Mode.overlay, // Mode.fullscreen
    //     language: "fr",
    //     components: [new Component(Component.country, "id")]);
    //
    // if(p != null){
    //   final places = new GoogleMapsPlaces(apiKey: "AIzaSyDPq_TPd_Jdc_ktaLzFIU2e30GoF11yBvc");
    //   PlacesDetailsResponse response = await places.getDetailsByPlaceId(p.placeId);
    //   if(response != null){
    //     // controller.currentAddress.value = response.result.formattedAddress;
    //     // controller.edtSearch.text = response.result.name;
    //     cameraMove(CameraPosition(
    //         target: LatLng(response.result.geometry.location.lat, response.result.geometry.location.lng),
    //         zoom: 19.151926040649414
    //     ));
    //   }
    // }

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.currentAddress,
        builder: (context, snapshot) {
          String addrs = '';
          if(snapshot.data != null){
            addrs = snapshot.data.toString();
          }
          return StreamBuilder(
              stream: bloc.currentAddressName,
              builder: (context, snapshot) {
              String addrsName = '';
              if(snapshot.data != null){
                addrsName = snapshot.data.toString();
              }
              return Container(
                child: Column(
                  children: [
                    Container(
                      color: Utils.colorFromHex(ColorCode.bluePrimary),
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.04),
                          TextAvenir('Lokasi Domisili', color: Colors.white, size: 20, ),
                          SizedBox(height: 25),
                          // Icon(Icons.search_rounded, color: Colors.black87,),
                          InkWell(
                            onTap: ()=>loadAutocomplete(),
                            child: BoxBorderDefault(
                                child: TextField(
                                  controller: bloc.edtSearch,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Cari lokasi',
                                      hintStyle: TextStyle(color: Utils.colorFromHex('#CCCCCC')),
                                      contentPadding: EdgeInsets.only(bottom:16),
                                  ),
                                  enabled: false,
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Stack(
                          children: [
                            GoogleMap(
                              myLocationEnabled: true,
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                setState(() {
                                  googleMapController = controller;
                                  _controller.complete(controller);
                                });
                              },
                              onCameraMove: (pos){
                                cameraPosition = pos;
                              },
                              onCameraIdle: () async {
                                bloc.changeAddress(cameraPosition!);
                              },
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 50),
                                child: GestureDetector(
                                  onTap: () {
                                    // if (bloc.currentLocation != null) {
                                    //   _goToSpecifiedPosition(LatLng(bloc.currentLocation.latitude,
                                    //       bloc.currentLocation.longitude));
                                    // }
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 30),
                                        height: size.height * 0.08,
                                        padding: EdgeInsets.only(bottom: 20),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          image: DecorationImage(
                                            image: AssetImage(ImageConstant.boxPin),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text('Geser peta untuk tentukan domisili anda',
                                            style: TextStyle(color: Colors.white))
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Image.asset(
                                          ImageConstant.markerPin,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              )
                            ),
                            // addrsName != '' ? Wrap(
                            //   children: [
                            //     Container(
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.all(Radius.circular(10)),
                            //         color: Colors.white,
                            //         boxShadow: [
                            //           BoxShadow(
                            //             color: Utils.colorFromHex(ColorCode.lightGreyElsimil),
                            //             spreadRadius: 2,
                            //             blurRadius: 7,
                            //             offset: Offset(0,0),
                            //           ),
                            //         ],
                            //       ),
                            //       padding: EdgeInsets.all(20),
                            //       margin: EdgeInsets.all(20),
                            //       width: double.infinity,
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           TextAvenir(addrsName, color: Colors.black45, size: 14, weight: FontWeight.w600,),
                            //           SizedBox(height: 10),
                            //           Text(addrs, style: TextStyle(color: Colors.black45, fontSize: 13),),
                            //         ],
                            //       ),
                            //     )
                            //   ],
                            // ):SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StreamBuilder(
        stream: bloc.currentAddress,
        builder: (context, snapshot) {
          String addrs = '';
          if(snapshot.data != null){
            addrs = snapshot.data.toString();
          }
          return Wrap(
            children: [
              InkWell(
                onTap: (){
                  ModelLocation model = ModelLocation();
                  model.latitude = bloc.posLat.toString();
                  model.longitude = bloc.posLon.toString();
                  Navigator.pop(context, model);
                },
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: addrs != '' ? Utils.colorFromHex(ColorCode.blueSecondary):Utils.colorFromHex(ColorCode.greyElsimil),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0,0),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Center(
                    child: TextAvenir(
                      'Lanjutkan',
                      size: 20,
                      color: addrs != '' ? Colors.white:Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }

  loadAutocomplete() async {

    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: 'AIzaSyDbURAmd-bG6EpWJby9qb2txnJLMxbHoFM',
      onError: (PlacesAutocompleteResponse data){},
      language: "id",
      types: [''],
      strictbounds: false,
      logo: Container(),
      components: [Component(Component.country, "id")],
    );

    // Prediction p = await PlacesAutocomplete.show(
    //     context: context,
    //     mode: Mode.fullscreen,
    //     // apiKey: 'AIzaSyDPq_TPd_Jdc_ktaLzFIU2e30GoF11yBvc',
    //     apiKey: 'AIzaSyDthndeninlwCBKshAwg8yTqqWsUEHVb04',
    //     language: 'id',
    //     components: [new Component(Component.country, "id")]
    // );
    if (p != null) {
      final places = new GoogleMapsPlaces(apiKey: "AIzaSyDbURAmd-bG6EpWJby9qb2txnJLMxbHoFM");
      // final places = new GoogleMapsPlaces(apiKey: "AIzaSyDPq_TPd_Jdc_ktaLzFIU2e30GoF11yBvc");
      PlacesDetailsResponse response = await places.getDetailsByPlaceId(p.placeId!);
      if(response != null){
        bloc.edtSearch.text = response.result.name;
        bloc.changeAddressName(response.result.name, response.result.formattedAddress!);
        cameraMove(CameraPosition(
            target: LatLng(response.result.geometry!.location.lat, response.result.geometry!.location.lng),
            zoom: 19.151926040649414
        ));
      }
    }
  }

  headerTitle(){
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(
              color: Colors.blue
          )
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.search, color: Colors.grey,),
          SizedBox(width: 10),
          Expanded(
              child: TextFormField(
                style: TextStyle(color: Colors.grey.shade300, fontSize: 13),
                // style: TStyleRevamp.regular.copyWith(color: ColorRevamp.darkGrey3, fontSize: 13),
                // controller: controller.edtSearch,
                textInputAction: TextInputAction.search,
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  hintText:
                  'Cari Lokasi jalan / perumahan / gedung',
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  contentPadding: EdgeInsets.only(bottom: 10)
                ),
              )
          ),
        ],
      ),

    );
  }

  Future<void> cameraMove(CameraPosition cameraPosition) async {
    final GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    bloc.changeLatLon(cameraPosition.target.latitude, cameraPosition.target.longitude);

  }

  cameraIdle() async{
    List<Placemark> placemarks = await placemarkFromCoordinates(bloc.posLat, bloc.posLon);
    Placemark place = placemarks[0];
    bloc.changeAddressName(place.name!, '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}');
  }
}
