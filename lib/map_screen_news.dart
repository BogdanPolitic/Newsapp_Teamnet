//import 'package:flutter/material.dart';
//import 'package:news_app/map_screen.dart';
//import 'package:redux/redux.dart';
//import 'models/app_state.dart';
//
//class MapScreenNews extends StatefulWidget {
//  Store<AppState> store = Store<AppState>(
//    appReducer,
//    initialState: AppState.initial(),
//    middleware: createStoreMiddleware(),
//  );
//
//  @override
//  Widget build(BuildContext context) => StoreProvider(
//    store = this.store,
//    child: MaterialApp(
//      home: MapScreenNews(),
//    ),
//  );
//  }
//
// class AppState{
//  final List<NewsItem> newsItm;
//  final ListState listState;
//
//  AppState(
//      this.newsItm,
//      this.listState,
//      );
//  factory AppState.initial() => AppState(List.unmodifiable([]),ListState.listOnly);
//
//
// }
//
//
//
//
//
//
//
////Widget _buildContainer(){
////  return Align(
////    alignment: Alignment.bottomLeft,
////    child: Container(
////      margin: EdgeInsets.symmetric(vertical: 20.0),
////      height: 150.0,
////      child: ListView(
////        scrollDirection: Axis.horizontal,
////        children: <Widget>[
////          SizedBox(width: 10.0),
////          Padding(
////            padding: const EdgeInsets.all(8.0),
////            child: _boxes(
////           "https://groups.runtogether.co.uk/Library/MoorRunningFriends2?command=Proxy&lang=en&type=Files&currentFolder=%2F&hash=3c454b7e955e0774aae5ef06a8b5e8e914b55462&fileName=news.jpg",
////                44.433999,26.050030,"News"),
////          ),
////
////          SizedBox(width: 10.0),
////          Padding(
////            padding: const EdgeInsets.all(8.0),
////            child: _boxes(
////                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtjUjjAvcgDUjvKpYTSmppYlTa-Nti5o6hYrHopohcalRALmgiHA",
////                44.435284,26.046062,"News2"),
////          ),
////
////        ],
////      ),
////    ),
////  );
////}
////
////
////Widget _boxes(String _image, double lat, double long, String newsName){
////  return GestureDetector(
////    onTap: (){
////     // loadMarkers();
////    },
////    child: Container(
////      child: FittedBox(
////        child: Material(
////          color: Colors.white,
////          elevation: 14.0,
////          borderRadius: BorderRadius.circular(24.0),
////          shadowColor: Color(0x802196F3),
////          child: Row(
////            mainAxisAlignment: MainAxisAlignment.spaceBetween,
////            children: <Widget>[
////              Container(
////                width: 180,
////                height: 200,
////                child: ClipRRect(
////                  borderRadius: BorderRadius.circular(24.0),
////                  child: Image(
////                    fit: BoxFit.fill,
////                    image: NetworkImage(_image),
////                  ),
////                ),
////              ),
////              Container(
////                child: Padding(
////                  padding: const EdgeInsets.all(8.0),
////                  child: myDetailsContainer(newsName),
////                ),
////              ),
////            ],
////
////          ),
////        ),
////      ),
////    ),
////  );
////}
////
////Widget myDetailsContainer(String newsName) {
////  return Column(
////      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
////      children: <Widget>[
////        Padding(
////          padding: const EdgeInsets.only(left: 8.0),
////          child: Container(
////          child: Text(newsName,
////          style: TextStyle(
////          color: Color(0xff6200ee),
////          fontSize: 24.0,
////          fontWeight: FontWeight.bold),
////        ),
////        ),
////        ),
////        SizedBox(height:5.0),
////        Container(
////          child: Row(
////          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
////          children: <Widget>[
////            Container(
////            child: Text(
////            "4.1",
////            style: TextStyle(
////            color: Colors.black54,
////            fontSize: 18.0,
////            ),
////            ),
////           ),
////          ],
////         ),
////        )
////       ],
////    );
////}
