import 'package:flutter/material.dart';

class ButtonBeLike extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row (

    );
  }
}

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
      itemCount: buttonFilterArr.length,
      itemBuilder: (context, index) => GestureDetector(
//        onTap: ,
        child: ButtonBeLike(),
      ),
    );
  }
}

