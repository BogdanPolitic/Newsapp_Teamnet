import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'map_screen.dart';

void main() async {
  final Firestore firestore = Firestore.instance;
  await firestore.settings(persistenceEnabled:false, timestampsInSnapshotsEnabled: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
    );
  }
}

//class MyHomePage extends StatefulWidget {
//
//  @override
//  MyHomePageState createState() => MyHomePageState();
//}
//
//class MyHomePageState extends State<MyHomePage> {
//
//  @override
//  void initState(){
//    super.initState();
//    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.portraitUp,
//    ]);
//  }
//
//  bool bigSwitchSort = false;
//  bool switchSortDate = true;
//  bool switchSortTitle = false;
//
//  void functionSwitchSortDate (bool val) {
//    setState(() {
//      print(val);
//      switchSortDate = !switchSortDate;
//      val = switchSortDate;
//      return val;
//    });
//  }
//  void functionSwitchSortTitle (bool val) {
//    setState(() {
//      print(val);
//      switchSortTitle = !switchSortTitle;
//      val = switchSortTitle;
//      return val;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        drawer: Drawer(
//          child: ListView(
//            children: <Widget>[
//              DrawerHeader(
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Container(
//                      margin: const EdgeInsets.all(5),
//                      width: MediaQuery.of(context).size.width * 0.25,
//                      height: MediaQuery.of(context).size.width * 0.25,
//                      decoration: BoxDecoration(
//                        color: Colors.red,
//                        shape: BoxShape.circle,
//                      ),
//                    ),
//                    Text('user\'s name here'),
//                    Text('user\'s email here'),
//                  ],
//                ),
//                decoration: BoxDecoration(color: Colors.blue),
//              ),
//              ListTile(),
//              ListTile(),
//              ListTile(),
//            ],
//          ),
//        ),
//        appBar: AppBar(
//          title: Text('Home'),
//        ),
//        body: Container(
//          height: MediaQuery.of(context).size.width * 0.16,
//          decoration: BoxDecoration(
//            color: Colors.purple,
//          ),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Switch(
//                value: switchSortDate,
//                onChanged: functionSwitchSortDate,
//              ),
//              Switch(
//                value: switchSortTitle,
//                onChanged: functionSwitchSortTitle,
//              ),
//            ],
//          ),
//
//
//        )
//    );
//  }
//}
