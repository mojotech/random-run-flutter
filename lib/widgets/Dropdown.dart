import 'package:flutter/material.dart';
import 'package:random_run/theme.dart' as T;

class Dropdown extends StatefulWidget {
  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  //TODO: need a better way of managing state (like redux).
  //https://medium.com/flutter-community/let-me-help-you-to-understand-and-choose-a-state-management-solution-for-your-app-9ffeac834ee3
  String dropdownValue = 'miles';
  static const Color grayPink = T.RandomRunColors.grayPink;
  static const Color brightPink = T.RandomRunColors.brightPink;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: grayPink,
      ),
      child: Container(
        margin: EdgeInsets.only(
          top: T.Spacing.medium,
        ),
        decoration: BoxDecoration(
          color: grayPink,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
            ),
          ],
        ),
        width: T.Spacing.xlarge,
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconEnabledColor: brightPink,
              iconSize: 25,
              elevation: 16,
              style: TextStyle(
                color: brightPink,
                fontSize: T.FontSize.small,
                fontWeight: FontWeight.w400,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['miles', 'kilometers']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(
                    child: Text(value),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
