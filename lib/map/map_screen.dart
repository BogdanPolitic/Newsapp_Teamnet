import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/pages/news.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatefulWidget {
  final FirebaseUser user;
  MapScreen({this.user});

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
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome(user: widget.user)));
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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'News map',
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

}


