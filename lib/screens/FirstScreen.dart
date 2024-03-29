import 'package:flutter/material.dart';
import 'package:random_run/theme.dart' as T;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:random_run/widgets/Picker.dart';
import 'package:random_run/widgets/Dropdown.dart';
import 'package:random_run/widgets/NextButton.dart';
import 'package:random_run/bloc/change_unit.dart';
import 'package:random_run/bloc/picker.dart';

class FirstScreen extends StatelessWidget {
  static Color brightPink = T.RandomRunColors.brightPink;

  final TextStyle _howFarStyle = TextStyle(
    fontSize: T.FontSize.small,
    fontWeight: FontWeight.w500,
    color: brightPink,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T.appBar,
        backgroundColor: brightPink,
      ),
      body: BlocBuilder<PickerBloc, PickerState>(
        builder: (context, pickerState) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'How far would you like to run?',
                  style: _howFarStyle,
                ),
                Picker(
                  bloc: BlocProvider.of<PickerBloc>(context),
                  pickerValue: pickerState.pickerValue,
                ),
                _dropDown,
                NextButton(
                  disabled: pickerState.pickerValue == '0.0',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final Widget _dropDown = BlocBuilder<ChangeUnitBloc, ChangeUnitState>(
    builder: (context, state) {
      final dropdownItems = <String>['miles', 'kilometers'];
      final value = state.dropdownValue;
      final dropdownBloc = BlocProvider.of<ChangeUnitBloc>(context);

      return Dropdown(
        selectedValue: value,
        items: dropdownItems,
        bloc: dropdownBloc,
      );
    },
  );
}
