import 'package:flutter/material.dart';
import 'package:random_run/theme.dart' as T;
import 'package:bloc/bloc.dart';
import 'package:random_run/bloc/change_unit.dart';

class Dropdown extends StatelessWidget {
  final String _value;
  final Bloc _bloc;
  final List<String> _items;

  static const Color grayPink = T.RandomRunColors.grayPink;
  static const Color brightPink = T.RandomRunColors.brightPink;

  Dropdown({
    @required String selectedValue,
    @required List<String> items,
    @required Bloc bloc,
  })  : _value = selectedValue,
        _bloc = bloc,
        _items = items;

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
              value: _value,
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
                _bloc.dispatch(DropdownChanged(newValue: newValue));
              },
              items: _items.map<DropdownMenuItem<String>>((String value) {
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
