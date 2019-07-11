import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'models/app_state.dart';

//class ButtonBeLike extends StatelessWidget {
//
//  int buttonIdx;
//
//  ButtonBeLike(int buttonIdx) {
//    this.buttonIdx = buttonIdx;
//  }
//
//
//
//  @override
//  Widget build(BuildContext context) {
//
////    print(MediaQuery.of(context).size.width * 0.25);
//
//    return StoreConnector(
//      converter: (Store<AppState> store) => store.state,
//      builder: (BuildContext context, AppState appState) {
//
//        return CheckboxListTile(
//          title: Text(data),
//          value: true,
//          onChanged: makeChange,
//        );
//
////        return Row (
////          children: <Widget>[
////            Icon(Icons.check_box_outline_blank),
//////            appState.buttonCheckers[buttonIdx] ?
////            SizedBox (
////              width: MediaQuery.of(context).size.width * 0.25,
////            ),
////          ],
////        );
//      }
//
//    );
//  }
//}

class FilterButtons {
  FilterButtons(this.name) {
    isChecked = false;
  }

  bool isChecked;
  final String name;
}

class MakeFilterButtons extends StatelessWidget {
  final List<FilterButtons> buttonFilterArr = <FilterButtons>[
    FilterButtons('Science & Tech'),
    FilterButtons('Life Style'),
    FilterButtons('Sports'),
    FilterButtons('Politics'),
    FilterButtons('Celebrities'),
  ];

  int returnNumList() {
    return buttonFilterArr.length;
  }

  void makeChange(bool myVal) {
    myVal = !myVal;
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      itemCount: buttonFilterArr.length,
      itemBuilder: (context, index) => GestureDetector(
//        onTap: ,
        child: StoreConnector(
            converter: (Store<AppState> store) => store.state,
            builder: (BuildContext context, AppState appState) {

              return CheckboxListTile(
                title: Text(buttonFilterArr[index].name),
                value: appState.buttonCheckers[index],
                onChanged: makeChange,
              );

//        return Row (
//          children: <Widget>[
//            Icon(Icons.check_box_outline_blank),
////            appState.buttonCheckers[buttonIdx] ?
//            SizedBox (
//              width: MediaQuery.of(context).size.width * 0.25,
//            ),
//          ],
//        );
            }

        ),
      ),
    );
  }
}

