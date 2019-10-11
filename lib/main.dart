import 'package:flutter/material.dart';
import 'package:random_run/bloc/change_unit.dart';
import 'package:random_run/bloc/picker.dart';
import 'theme.dart' as Theme;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_run/screens/FirstScreen.dart';
import 'package:random_run/screens/SecondScreen.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ChangeUnitBloc>(
          builder: (context) => ChangeUnitBloc(),
        ),
        BlocProvider<PickerBloc>(
          builder: (context) => PickerBloc(),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Run',
      color: Theme.RandomRunColors.brightPink,
      theme: Theme.randomRunThemeData,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SecondScreen(),
      },
    );
  }
}
