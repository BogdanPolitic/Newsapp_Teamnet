// lib/main.dart
// Gasit tutorial asemanator cu ce a facut Cristi astazi la prezentare
import 'package:flutter/material.dart';

//import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../models/models.dart';

//import '../reducers/app_reducer.dart';
import '../actions/actions.dart';
import '../filtre_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

int numCharactersOfPreview;

class Entry {
  final String title;
  final String fullDescription;
  final String imageUrl;

  Entry(this.title, this.fullDescription, this.imageUrl);
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
  //TabController _modalTabController;
  ScrollController _scrollViewController;
  //ScrollController _modalScrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    //_modalTabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    //_modalScrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    //_modalScrollViewController.dispose();
    super.dispose();
  }

  Widget _content(BuildContext context) {
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
          PageOne(),
          PageTwo(),
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.25,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.125,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    'user\'s name here:',
                    style: TextStyle(
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.021,
                    ),
                  ),
                  Text(
                    'user\'s email here: ${widget.user.email}',
                    style: TextStyle(
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.021,
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
                  fontSize: MediaQuery
                      .of(context)
                      .size
                      .height * 0.025,
                ),
              ),
              children: <Widget>[
                MakeFilterButtons(),
              ],
            ),
          ],
        ),
      ),
      body: _content(context),
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
  List<Entry> entries;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery
        .of(context)
        .size
        .width;
    double _height = MediaQuery
        .of(context)
        .size
        .height;
    entries = _populateEntries();
    return ListView.builder(
      itemCount: entries.length,
      itemExtent: 250.0,
      itemBuilder: (context, index) =>
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.6,
                  //height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: <Widget>[
                      Text(
                        entries[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        previewOf(
                          entries[index].fullDescription,
                          85,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.2,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.1,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: FittedBox(
                        child: Image.network(
                          entries[index].imageUrl,
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
                          context, _width, _height, entries[index],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}

class PageTwo extends StatelessWidget {
  List<Entry> entries;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery
      .of(context)
      .size
      .width;
  double _height = MediaQuery
      .of(context)
      .size
      .height;
    entries = _populateEntries();
    return ListView.builder(
      itemCount: entries.length,
      itemExtent: 250.0,
      itemBuilder: (context, index) =>
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.6,
                  //height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: <Widget>[
                      Text(
                        entries[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        previewOf(
                          entries[index].fullDescription,
                          85,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.2,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.1,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: FittedBox(
                        child: Image.network(
                          entries[index].imageUrl,
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
                          context, _width, _height, entries[index],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}

void _settingModalBottomSheet(context, width, height, entry) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
            itemCount: 3,
            itemExtent: 250,
            itemBuilder: (context, index) => modalComponent(entry, index),
        );
      },
  );
}

Widget modalComponent(entry, index) {
  switch (index) {
    case 0:
      return Text(entry.title + '0');
    case 1:
      return Text(entry.fullDescription + '2');
    case 2:
      return Image.network(entry.imageUrl);
    default:
      return null;
  }
}

List<Entry> _populateEntries() {
  List<Entry> l = [
    Entry(
      'McDonald\'s',
      'McDonald\'s is an American fast food company, founded in 1940 as a restaurant operated by Richard and Maurice McDonald, in San Bernardino, California, United States. They rechristened their business as a hamburger stand, and later turned the company into a franchise, with the Golden Arches logo being introduced in 1953 at a location in Phoenix, Arizona. In 1955, Ray Kroc, a businessman, joined the company as a franchise agent and proceeded to purchase the chain from the McDonald brothers. McDonald\'s had its original headquarters in Oak Brook, Illinois, but moved its global headquarters to Chicago in early 2018.',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/McDonald%27s_Golden_Arches.svg/240px-McDonald%27s_Golden_Arches.svg.png',
    ),
    Entry(
      'Jupiter',
      'Jupiter is the fifth planet from the Sun and the largest in the Solar System. It is a giant planet with a mass one-thousandth that of the Sun, but two-and-a-half times that of all the other planets in the Solar System combined. Jupiter and Saturn are gas giants; the other two giant planets, Uranus and Neptune, are ice giants. Jupiter has been known to astronomers since antiquity.[17] It is named after the Roman god Jupiter.[18] When viewed from Earth, Jupiter can reach an apparent magnitude of −2.94, bright enough for its reflected light to cast shadows,[19] and making it on average the third-brightest natural object in the night sky after the Moon and Venus.',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Jupiter_and_its_shrunken_Great_Red_Spot.jpg/440px-Jupiter_and_its_shrunken_Great_Red_Spot.jpg',
    ),
    Entry(
      'Insula Iubirii',
      'Temptation Island – Insula iubirii“, un reality-show filmat pe plajele exotice din Thailanda care pune la încercare relaţia a patru cupluri, va debuta duminică, 26 aprilie, la Antena 1, de la ora 20:30.',
      'https://adevarul.ro/assets/adevarul.ro/MRImage/2015/04/23/5538b4d5cfbe376e35787d1b/646x404.jpg',
    ),
    Entry(
      'Brexit',
      'In what could be his final interview as business secretary, Greg Clark didn\'t pull punches about the damage of a no-deal Brexit. Many Brexiteers call it Project Fear but Greg Clark says it is just the reality of his conversations with businesses up and down the country: thousands of jobs will be lost if the next prime minister presses on with a no-deal Brexit. In what could be his final interview as business secretary, Mr Clark didn\'t pull his punches about the damage a no-deal could do to UK business as he warned his colleagues that the "discussions and evidence business and industry has presented" over the last three years is not "somehow forgotten" in the rush to get Brexit across the line.His Brexiteer opponents believe that he - together with Chancellor Philip Hammond - have dragged their heels over no-deal planning and sought to frustrate the UK\'s departure from the EU.',
      'https://e3.365dm.com/19/07/2048x1152/skynews-greg-clark-conservative_4715913.jpg?bypass-service-worker&20190712011516',
    ),
  ];
  return l;
}

String previewOf(String text, int numberOfCharacters) {
  return text.substring(0, numberOfCharacters - 1) + '...';
}
