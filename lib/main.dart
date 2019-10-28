import 'package:flutter/material.dart';
import 'package:random_run/bloc/change_unit.dart';
import 'package:random_run/bloc/picker.dart';
import 'theme.dart' as Theme;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_run/screens/FirstScreen.dart';
import 'package:random_run/screens/SecondScreen.dart';
import 'package:random_run/screens/ThirdScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

Future main() async {
  await DotEnv().load('.env');
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
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
      },
    );
  }
}
