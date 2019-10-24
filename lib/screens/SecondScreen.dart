import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_run/theme.dart' as T;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart' as gws;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_run/bloc/picker.dart';
import 'package:random_run/bloc/change_unit.dart';
import 'package:latlong/latlong.dart' as LatLong;
import 'package:random_run/utils/unit_conversion.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T.appBar,
        backgroundColor: T.RandomRunColors.brightPink,
      ),
      body: BlocBuilder<PickerBloc, PickerState>(
        builder: (_, pickerState) {
          return BlocBuilder<ChangeUnitBloc, ChangeUnitState>(
            builder: (_, unitState) {
              return SecondScreenBody(
                distance: pickerState.pickerValue,
                unit: unitState.dropdownValue,
              );
            },
          );
        },
      ),
    );
  }
}

class SecondScreenBody extends StatefulWidget {
  final String distance;
  final String unit;

  SecondScreenBody({@required this.distance, @required this.unit});

  @override
  _SecondScreenBodyState createState() => _SecondScreenBodyState();
}

class _SecondScreenBodyState extends State<SecondScreenBody> {
  final directions =
      gws.GoogleMapsDirections(apiKey: DotEnv().env['GOOGLE_MAPS_API_KEY']);
  GoogleMapController mapController;
  double _lat;
  double _lng;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  String calculatedDistance = '';
  Position _currentPosition;

  final EdgeInsets _buttonMargins = EdgeInsets.only(
    top: T.Spacing.mediumLarge,
    bottom: T.Spacing.mediumLarge,
    left: T.Spacing.smallMedium,
    right: T.Spacing.smallMedium,
  );

  @override
  void initState() {
    super.initState();
    _asyncInitState();
  }

  @override
  void dispose() {
    super.dispose();
    directions.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_lat != null && _lng != null) {
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
                      calculatedDistance,
                      style: TextStyle(
                        fontSize: T.FontSize.medium,
                        color: T.RandomRunColors.brightPink,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: T.Spacing.micro,
                      ),
                      child: Text(
                        widget.unit,
                        style: TextStyle(
                          fontSize: T.FontSize.medium,
                          color: T.RandomRunColors.brightPink,
                        ),
                      ),
                    )
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
                      onPressed: () => Navigator.pushNamed(context, '/third'),
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
    } else {
      return Container();
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _asyncInitState() async {
    await _getCurrentLocation();
    if (_currentPosition != null) {
      setState(() {
        _lat = _currentPosition.latitude;
        _lng = _currentPosition.longitude;
      });
      _addMarker(LatLng(_lat, _lng), "origin");
      _getPolylines();
    }
  }

  Future<void> _getCurrentLocation() async {
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    if (geolocationStatus == GeolocationStatus.granted) {
      setState(() {
        _currentPosition = position;
      });
    }
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
    gws.DirectionsResponse res = await directions.directions(
      gws.Location(_lat, _lng),
      gws.Location(_lat, _lng),
      waypoints: _getRandomWaypoints(),
      travelMode: gws.TravelMode.walking,
    );

    if (res.isOkay) {
      for (var r in res.routes) {
        List<PointLatLng> points =
            PolylinePoints().decodePolyline(r.overviewPolyline.points);
        polylineCoordinates.clear();
        points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        _addPolyLine();
        _calculateDistance(res.routes);
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

  List<gws.Waypoint> _getRandomWaypoints() {
    final List<gws.Waypoint> waypoints = [];

    var N = new Random().nextInt(6) + 4;
    double distanceInMeters =
        convertDistanceToMeters(widget.distance, widget.unit);
    int scaledRadiusInMeters =
        ((distanceInMeters / (2 * pi)) / sqrt(2)).round();

    final LatLong.Distance distance = const LatLong.Distance();
    int initialHeading = new Random().nextInt(360);

    LatLong.LatLng center = distance.offset(
      LatLong.LatLng(_lat, _lng),
      scaledRadiusInMeters,
      initialHeading,
    );

    for (var i = 1; i < N; i++) {
      int newHeading =
          ((((initialHeading + 180) % 360) + (360 / N) * i) % 360).round();
      LatLong.LatLng waypoint =
          distance.offset(center, scaledRadiusInMeters, newHeading);
      waypoints.add(gws.Waypoint.fromLocation(
          gws.Location(waypoint.round().latitude, waypoint.round().longitude)));
    }
    return waypoints;
  }

  _calculateDistance(List<gws.Route> routes) {
    int totalDistance = routes.fold(
        0,
        (distance, route) =>
            distance +
            route.legs.fold(0, (meters, leg) => meters + leg.distance.value));
    calculatedDistance = convertMetersToDistance(totalDistance, widget.unit);
  }
}
