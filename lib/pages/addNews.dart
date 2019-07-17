import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import 'news.dart';

class AddNew extends StatefulWidget {
  final AsyncSnapshot<DocumentSnapshot> snapshot;
  final FirebaseUser user;

  AddNew({this.snapshot, this.user});

  State<AddNew> createState() {
    return _AddNewState();
  }
}

class _AddNewState extends State<AddNew> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    Map<String, String> newData = {};
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new new'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (input) =>
                input.length < 5 ? 'Please type a longer title' : null,
                onSaved: (input) {
                  newData['title'] = input;
                },
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                validator: (input) =>
                input.length < 5 ? 'Please type a valid image url' : null,
                onSaved: (input) {
                  newData['imageUrl'] = input;
                },
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              TextFormField(
                validator: (input) =>
                input.length < 20 ? 'Please type a longer content' : null,
                onSaved: (input) {
                  newData['content'] = input;
                },
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                validator: (input) =>
                input.length < 8 ? 'Please type a longer number' : null,
                onSaved: (input) {
                  newData['latitude'] = input;
                },
                decoration: InputDecoration(labelText: 'Latitude'),
              ),
              TextFormField(
                validator: (input) =>
                input.length < 8 ? 'Please type a longer number' : null,
                onSaved: (input) {
                  newData['longitude'] = input;
                },
                decoration: InputDecoration(labelText: 'Longitude'),
              ),
              StreamBuilder(
                stream: Firestore.instance.collection('newsCoord').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshotCoords) {
              return RaisedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    final _formState = _key.currentState;
                    if (_formState.validate()) {
                      _formState.save();
                      int greatestId = widget.snapshot.data['id'];
                      CollectionReference newsCollection = Firestore.instance.collection('usersAndNews').document('info').collection('news');
                      newsCollection.document('greatest_id').updateData({'id' : greatestId + 1});
                      newsCollection.document('id_new_${greatestId + 1}').setData({
                        'content' : newData['content'],
                        'imageUrl' : newData['imageUrl'],
                        'title' : newData['title'],
                        //'latitude' : newData['latitude'],
                        //'longitude' : newData['longitude']
                      });
                      CollectionReference coordsCollection = Firestore.instance.collection('newsCoord');
                      coordsCollection.document('id_new_${greatestId + 1}').setData({
                        'location' : LatLng(double.parse(newData['latitude']), double.parse(newData['longitude'])),
                        'title' : newData['title'],
                      });

                      snapshotCoords.data.documents
                          .map((doc) => print(doc.documentID));

                      print('id_new_${greatestId + 1}');
                      Navigator.pop(context);
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHome(user: widget.user),
                        ),
                      );*/
                    }
                  });}),
            ],
          ),
        ),
      ),
    );
  }
}