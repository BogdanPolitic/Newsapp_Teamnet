import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:news_app/map_screen_news.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  static Completer<GoogleMapController> mapController = Completer();
  static  cameraFocus(LatLng _location, {double zoom: 17.0}) async {
    final GoogleMapController controller = await mapController.future;
    var pos = await Geolocator().getCurrentPosition();
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0.0,
          target: LatLng(pos.latitude, pos.longitude),
          tilt: 0.0,
          zoom: 17.0,
        ),
      ),
    );
    _addGeoPoint(pos);
  }
  static final LatLng _center = const LatLng(44.4336306,26.0493213);

  Set<Marker> markers = Set();
  MapType _currentMapType = MapType.normal;
  LatLng centerPosition;


  static Future<DocumentReference> _addGeoPoint(Position pos) async {
    var pos = await Geolocator().getCurrentPosition();
   GeoFirePoint point = Geoflutterfire().point(latitude: pos.latitude, longitude: pos.longitude);
    return Firestore.instance.collection('newsCoord').add({
      'position' : point.data,
      'name' : 'TEST TEST'
    });
  }

  loadMarkers() {
    Firestore.instance.collection('newsCoord').getDocuments().then((docs) {
        if(docs.documents.isNotEmpty){
          for(int i=0;i<docs.documents.length;i++){
            if(docs.documents[i] != null)
             initMarker(docs.documents[i].data,docs.documents[i].documentID);
          }
        }
      });
  }

  void initMarker(client, markerRef){
    var markerIDVal = markerRef;
    final MarkerId markerId = MarkerId(markerIDVal);

    InfoWindow infoWindow = InfoWindow(
      onTap: (){
        //Navigator.push(context, route)
      },
      title: client['title'],
    );

   final Marker marker = Marker(
     position: LatLng(client['location'].latitude, client['location'].longitude),
     markerId: markerId,
     infoWindow: infoWindow,

   );


   setState(() {
     markers.add(marker);
   });
  }

  @override
  Widget build(BuildContext context) {
    loadMarkers();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFF02BB9F),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Google map widget',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              mapType: _currentMapType,
              myLocationEnabled: true,
              markers: markers,
              onCameraMove: _onCameraMove,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.all(16.0),
//              child: Align(
//                alignment: Alignment.bottomLeft,
//                child: new FloatingActionButton(
//                  onPressed: _onMapTypeButtonPressed,
//                  child: new Icon(
//                    Icons.map,
//                    color: Colors.white,
//                  ),
//                ),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(16.0),
//              child: Align(
//                alignment: Alignment.bottomCenter,
//                child: new FloatingActionButton(
//                  onPressed: _onAddMarkerButtonPressed,
//                  child: new Icon(
//                    Icons.edit_location,
//                    color: Colors.white,
//                  ),
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    centerPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

//  void _onMapTypeButtonPressed() {
//    setState(() {
//      _currentMapType = _currentMapType == MapType.normal
//          ? MapType.satellite
//          : MapType.normal;
//    });
//  }




}


