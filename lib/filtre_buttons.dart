import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news_app/state_view_model.dart';
import 'package:redux/redux.dart';
import 'models/app_state.dart';

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

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      itemCount: buttonFilterArr.length,
      itemBuilder: (context, index) => GestureDetector(
//        onTap: ,
        child: StoreConnector(
            converter: (Store<AppState> store) => StateViewModel.fromStore(store),
            builder: (BuildContext context, StateViewModel stateViewModel) {

              return CheckboxListTile(
                title: Text(buttonFilterArr[index].name),
                value: stateViewModel.buttonCheckers[index],
                onChanged: (bool someVal) {
                  stateViewModel.changeCecker(index);
                },
//                onChanged: (covariant) => StoreProvider.of<AppState>(context)
//                    .dispatch(TestAction(appState.buttonCheckers[index])),
              );
            }
        ),
      ),
    );
  }
}
