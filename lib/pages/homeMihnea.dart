import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;

  const Home({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    data = {widget.user.uid : 'thisisme', 'new_2field' : 'new_2value'};
    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${widget.user.email}'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('users').document('users_doc').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch(snapshot.connectionState) {
            case ConnectionState.waiting: return Text('Loading..');
            default:
              data['new_f'] = 'nice_string';
              data.remove('new_2field');
              Firestore.instance.collection('users').document('users_doc').setData(data);
              return Text(snapshot.data[widget.user.uid]);
          }
        }
      ),
    );
  }
}
