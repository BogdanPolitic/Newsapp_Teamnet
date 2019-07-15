import 'package:flutter/material.dart';
//import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'authentication.dart';
import 'homeMihnea.dart'; // DEBUG
import 'package:firebase_auth/firebase_auth.dart'; // DEBUG

class RadialMenu extends StatefulWidget {
  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  static bool reverse;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    reverse = false;
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller);
  }
}

class RadialAnimation extends StatelessWidget {
  bool _visible = true;
  AnimationController controller;

  Animation<double> translation;
  Animation<double> rotation;

  RadialAnimation(this.controller);

  Widget build(BuildContext context) {
    translation = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    rotation = Tween<double>(
      begin: 0.0,
      end: 90.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
        ),
      ),
    );
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'T',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 60),
                  ),
                  TextSpan(
                    text: 'eamnet',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'N',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: 'ews',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text('',
                style: TextStyle(
                  fontSize: 20,
                )),
            Center(
              child: AnimatedOpacity(
                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                // The green box must be a child of the AnimatedOpacity widget.
                child: buildButton(
                  iconData: FontAwesomeIcons.solidDotCircle,
                  dy: translation.value,
                  context: context,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildButton({IconData iconData, double dy, BuildContext context}) {
    double angle = radians(rotation.value);
    return Transform.scale(
      scale: 2,
      child: Transform(
        transform: Matrix4.identity()..translate(0.0, translation.value),
        child: FloatingActionButton(
          child: Icon(iconData),
          onPressed: () async {
            if (!_RadialMenuState.reverse)
              controller.forward();
            else
              controller.reverse();
            _RadialMenuState.reverse = !_RadialMenuState.reverse;
            _visible = !_visible;
            await Future.delayed(const Duration(milliseconds: 600));

            // DEBUG
            FirebaseUser user = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                email: 'hello@gmail.com', password: 'worldd');
            // / DEBUG

            Navigator.push(context, MaterialPageRoute(builder: (context) => /*MyHome(user: user,)*/Authentication()));
          },
        ),
      ),
    );
  }
}