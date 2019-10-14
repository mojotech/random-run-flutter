import 'package:flutter/material.dart';
import 'package:random_run/theme.dart' as T;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_run/bloc/picker.dart';
import 'package:random_run/bloc/change_unit.dart';

class SecondScreen extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(41.8240, -71.4128);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final EdgeInsets _buttonMargins = EdgeInsets.only(
    top: T.Spacing.mediumLarge,
    bottom: T.Spacing.mediumLarge,
    left: T.Spacing.smallMedium,
    right: T.Spacing.smallMedium,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T.appBar,
        backgroundColor: T.RandomRunColors.brightPink,
      ),
      body: BlocBuilder<PickerBloc, PickerState>(
        builder: (context, pickerState) {
          return Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                myLocationButtonEnabled: false,
              ),
              Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: T.Spacing.small,
                      bottom: T.Spacing.small,
                      left: T.Spacing.large,
                      right: T.Spacing.large,
                    ),
                    padding: EdgeInsets.all(
                      T.Spacing.micro,
                    ),
                    decoration: BoxDecoration(
                      color: T.RandomRunColors.grayPink,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          pickerState.pickerValue,
                          style: TextStyle(
                            fontSize: T.FontSize.medium,
                            color: T.RandomRunColors.brightPink,
                          ),
                        ),
                        _distanceUnit
                      ],
                    ),
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: _buttonMargins,
                        height: T.Spacing.mediumLarge,
                        width: T.Spacing.mediumLarge,
                        child: FloatingActionButton(
                          heroTag: "refresh",
                          onPressed: () => print('refresh button pressed'),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: T.RandomRunColors.brightPink,
                          child: const Icon(Icons.refresh, size: T.Sizes.small),
                        ),
                      ),
                      Container(
                        margin: _buttonMargins,
                        height: T.Spacing.mediumLarge,
                        width: T.Spacing.mediumLarge,
                        child: FloatingActionButton(
                          heroTag: "accept",
                          onPressed: () =>
                              Navigator.pushNamed(context, '/third'),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.check, size: T.Sizes.small),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  final Widget _distanceUnit = BlocBuilder<ChangeUnitBloc, ChangeUnitState>(
    builder: (context, state) {
      return Container(
        margin: EdgeInsets.only(
          left: T.Spacing.micro,
        ),
        child: Text(
          state.dropdownValue,
          style: TextStyle(
            fontSize: T.FontSize.medium,
            color: T.RandomRunColors.brightPink,
          ),
        ),
      );
    },
  );
}
