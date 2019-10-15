//TODO: convert unit string to enum
double convertDistanceToMeters(String distanceStr, String unit) {
  double dist = double.parse(distanceStr);
  if (unit == "kilometers") {
    return dist * 1000;
  } else {
    return dist / 0.00062137;
  }
}

String convertMetersToDistance(int meters, String unit) {
  if (unit == "kilometers") {
    return (meters / 1000).toStringAsFixed(1);
  } else {
    return (meters * 0.00062137).toStringAsFixed(1);
  }
}
