import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/********* Event *************/

abstract class PickerEvent extends Equatable {}

class PickerChanged extends PickerEvent {
  final String newPickerValue;

  PickerChanged({@required this.newPickerValue});

  @override
  String toString() => "PickerChanged { newPickerValue: $newPickerValue }";
}

/********* State *************/

class PickerState extends Equatable {
  final String pickerValue;

  PickerState({@required this.pickerValue}) : super([pickerValue]);
}

/********* Bloc *************/

class PickerBloc extends Bloc<PickerEvent, PickerState> {
  @override
  PickerState get initialState => PickerState(pickerValue: '1.0');

  @override
  Stream<PickerState> mapEventToState(
    PickerEvent event,
  ) async* {
    if (event is PickerChanged) {
      yield PickerState(
        pickerValue: event.newPickerValue,
      );
    }
  }
}
