import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/********* Event *************/

abstract class ChangeUnitEvent extends Equatable {}

class DropdownChanged extends ChangeUnitEvent {
  final String newValue;

  DropdownChanged({@required this.newValue}) : super();

  @override
  String toString() => "DropdownChanged { newValue: $newValue }";
}

/********* State *************/

class ChangeUnitState extends Equatable {
  final String dropdownValue;

  ChangeUnitState({@required this.dropdownValue})
      : assert(dropdownValue != null),
        super([dropdownValue]);
}

/********* Bloc *************/

class ChangeUnitBloc extends Bloc<ChangeUnitEvent, ChangeUnitState> {
  @override
  ChangeUnitState get initialState => ChangeUnitState(dropdownValue: 'miles');

  @override
  Stream<ChangeUnitState> mapEventToState(
    ChangeUnitEvent event,
  ) async* {
    if (event is DropdownChanged) {
      yield ChangeUnitState(
        dropdownValue: event.newValue,
      );
    }
  }
}
