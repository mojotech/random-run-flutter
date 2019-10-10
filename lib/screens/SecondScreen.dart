import 'package:flutter/material.dart';
import 'package:random_run/theme.dart' as T;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SecondScreen extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(41.8240, -71.4128);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T.appBar,
        backgroundColor: T.RandomRunColors.brightPink,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
