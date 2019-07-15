import 'package:flutter/material.dart';
import '../filtre_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int numCharactersOfPreview;

class Entry {
  final String title;
  final String fullDescription;
  final String imageUrl;

  Entry(this.title, this.fullDescription, this.imageUrl);
}

class NewFormat {
  final Widget title;
  final Widget content;
  final Widget image;

  NewFormat(this.title, this.content, this.image);
}

class MyHome extends StatefulWidget {
  FirebaseUser user;

  MyHome({this.user});

  State<MyHome> createState() {
    return _MyHomeState();
  }
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  Widget _content(
      BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    return NestedScrollView(
      controller: _scrollViewController,
      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            title: Text('Tab Controller Example'),
            pinned: true,
            floating: true,
            forceElevated: boxIsScrolled,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "Last news",
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: "Fav news",
                  icon: Icon(Icons.help),
                )
              ],
              controller: _tabController,
            ),
          )
        ];
      },
      body: TabBarView(
        children: <Widget>[
          PageOne(snapshot: snapshot, user: widget.user),
          PageTwo(snapshot: snapshot, user: widget.user),
        ],
        controller: _tabController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.125,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    'user\'s name here:',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.021,
                    ),
                  ),
                  Text(
                    'user\'s email here: ${widget.user.email}',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.021,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ExpansionTile(
              title: Text(
                'Filters',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                ),
              ),
              children: <Widget>[
                MakeFilterButtons(),
              ],
            ),
          ],
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('users_and_news_collection')
              .document('info')
              .collection('users')
              .document(widget.user.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading..');
              default:
                return _content(context, snapshot);
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.control_point),
        onPressed: () {
          _tabController.animateTo(1,
              curve: Curves.bounceInOut, duration: Duration(milliseconds: 10));

          // _scrollViewController.animateTo(
          //     _scrollViewController.position.minScrollExtent,
          //     duration: Duration(milliseconds: 1000),
          //     curve: Curves.decelerate);

          _scrollViewController
              .jumpTo(_scrollViewController.position.maxScrollExtent);
        },
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  List<Entry> entries = [];
  final FirebaseUser user;
  final AsyncSnapshot<DocumentSnapshot> snapshot;

  PageOne({this.snapshot, this.user});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    //Widget newFormat = _populateEntries(snapshot);
    return StreamBuilder(
        stream: Firestore.instance
            .collection('usersAndNews')
            .document('info')
            .collection('news')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView(
            children: snapshot.data.documents
                .map((DocumentSnapshot document) => Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    //height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      children: <Widget>[
                        Text(
                          document.data['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          previewOf(
                            document.data['content'],
                            85,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height:
                        MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: FittedBox(
                          child: Image.network(
                            document.data['imageUrl'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Text('more details',
                            style: TextStyle(
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                            )),
                        onTap: () {
                          _settingModalBottomSheet(
                              context,
                              _width,
                              _height,
                              document,
                              user
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ))
                .toList(),
          );
        });
  }
}

class PageTwo extends StatelessWidget {
  final AsyncSnapshot<DocumentSnapshot> snapshot;
  final FirebaseUser user;
  PageTwo({this.snapshot, this.user});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void _settingModalBottomSheet(
    context, width, height, document, user) {
  //List<String> fields = ['title', 'content', 'imageUrl', 'buttons'];
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ListView.builder(
        itemCount: 4,
        itemExtent: null,
        itemBuilder: (context, index) => modalComponent(document, index, user),
      );
    },
  );
}

Widget modalComponent(document, field, user) {
  Map<IconData, Function> buttonActionMap = {Icons.thumb_up : like, Icons.favorite : favourite};
  switch (field) {
    case 0:
      return Image.network(document.data['imageUrl']);
    case 1:
      return Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        alignment: Alignment.center,
        child: Text(document.data['title'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            )),
      );
    case 2:
      return Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Text(
          '       ' + document.data['content'],
          textAlign: TextAlign.justify,
        ),
      );
    case 3:
      return Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icons.thumb_up, Icons.favorite]
              .map((iconData) => InkWell(
              child: Transform.scale(
                scale: 2,
                child: Icon(
                  iconData,
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                buttonActionMap[iconData](document, user);
              }
          ),)
              .toList(),
        ),
      );
    default:
      return nullContainer();
  }
}

String previewOf(String text, int numberOfCharacters) {
  return '    ' + text.substring(0, numberOfCharacters - 1) + '...';
}

Widget like(document, user) {
  print('${user.email} liked ${document.data['title']} of the new with the ID = ${document.documentID}!');
  return StreamBuilder(
      stream: Firestore.instance.collection('usersAndNews').document('info').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        return nullContainer();
      }
  );
}

Widget favourite(document, user) {
  print('${user.email} favourited ${document['title']}! of the new with the ID = ${document.documentID}!');
  List<String> favourites = document.data['favourites'];
  favourites.add(document.documentID.toString());
  document.data['favourites'].setData(favourites);
  print('DECII : ' + document.uid.toString());
  print("DECI: " + favourites.toString());
  return StreamBuilder(
      stream: Firestore.instance.collection('usersAndNews').document('info').snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        print('AJUNG');
        return nullContainer();
      }
  );
}

Widget nullContainer() {
  return Container(width: 0);
}
