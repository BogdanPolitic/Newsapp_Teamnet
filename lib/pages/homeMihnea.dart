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

//bool someVar = false;

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

      body: NestedScrollView(
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
      ),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            //height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Titlu stire',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text('Furtuna devastatoare de pe planeta Jupiter se va ameliora pana in anul 2033. Oamenii de stiinta aaaaa devastatoare de pe planeta Jupiter se va ameliora pana in anul 2033.'),
              ],
            ),
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  border: Border.all(),
                  //image: DecorationImage(
                  //  image: NetworkImage('https://comofuncionaque.com/wp-content/uploads/2015/07/Jupiter-un-planeta-caracterizado-por-los-remolinos-de-viento-que-le-aportan-esas-tonalidades-diferentes.jpg-1024x576.jpg'),
                  //),
                ),
                child: FittedBox(
                  child: Image.network('https://comofuncionaque.com/wp-content/uploads/2015/07/Jupiter-un-planeta-caracterizado-por-los-remolinos-de-viento-que-le-aportan-esas-tonalidades-diferentes.jpg-1024x576.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'more details',
                style: TextStyle(
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                )
              )
            ],
          )
        ],
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}
