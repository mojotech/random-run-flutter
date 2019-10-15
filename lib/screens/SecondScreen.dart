import 'package:flutter/material.dart';
import 'package:random_run/theme.dart' as T;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart' as gws;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_run/bloc/picker.dart';
import 'package:random_run/bloc/change_unit.dart';
import 'package:latlong/latlong.dart' as LatLong;

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final directions = gws.GoogleMapsDirections(apiKey: "");
  gws.DirectionsResponse res;
  GoogleMapController mapController;
  //TODO: lat/lng should be user's current location
  double _lat = 41.822740, _lng = -71.412500;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final EdgeInsets _buttonMargins = EdgeInsets.only(
    top: T.Spacing.mediumLarge,
    bottom: T.Spacing.mediumLarge,
    left: T.Spacing.smallMedium,
    right: T.Spacing.smallMedium,
  );

  @override
  void initState() {
    super.initState();

    _addMarker(LatLng(_lat, _lng), "origin");
    _getPolylines();
  }

  @override
  void dispose() {
    super.dispose();
    directions.dispose();
  }

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
                initialCameraPosition: CameraPosition(
                  target: LatLng(_lat, _lng),
                  zoom: 15.0,
                ),
                onMapCreated: _onMapCreated,
                markers: Set<Marker>.of(markers.values),
                polylines: Set<Polyline>.of(polylines.values),
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  _addMarker(LatLng position, String id) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: position,
    );
    markers[markerId] = marker;
  }

  Future<void> _getPolylines() async {
    final LatLong.Distance distance = const LatLong.Distance();
    // TODO: make this half the inputted distance from the user
    final num distanceInMeters = 300.0;

    final startingLocation = new LatLong.LatLng(_lat, _lng);
    // the last parameter of the offset function is the bearing (degrees)
    final offsetPoint = distance.offset(startingLocation, distanceInMeters, 0);

    res = await directions.directions(
      gws.Location(_lat, _lng),
      gws.Location(_lat, _lng),
      waypoints: [
        gws.Waypoint.fromLocation(gws.Location(
            offsetPoint.round().latitude, offsetPoint.round().longitude)),
      ],
    );

    if (res.isOkay) {
      for (var r in res.routes) {
        List<PointLatLng> points =
            PolylinePoints().decodePolyline(r.overviewPolyline.points);
        points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        _addPolyLine();
      }
    } else {
      print(res.errorMessage);
    }
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }
}
