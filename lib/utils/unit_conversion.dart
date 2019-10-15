//TODO: convert unit string to enum
double convertDistanceToMeters(String distanceStr, String unit) {
  double dist = double.parse(distanceStr);
  if (unit == "kilometers") {
    return dist * 1000;
  } else {
    return dist / 0.00062137;
  }
}
