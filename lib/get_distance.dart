import 'dart:math';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371; // Radius of the Earth in kilometers

  // Convert latitude and longitude from degrees to radians
  double lat1Rad = degreesToRadians(lat1);
  double lon1Rad = degreesToRadians(lon1);
  double lat2Rad = degreesToRadians(lat2);
  double lon2Rad = degreesToRadians(lon2);

  // Difference between latitudes and longitudes
  double latDiff = lat2Rad - lat1Rad;
  double lonDiff = lon2Rad - lon1Rad;

  // Haversine formula
  double a = pow(sin(latDiff / 2), 2) +
      cos(lat1Rad) * cos(lat2Rad) * pow(sin(lonDiff / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c;

  return distance;
}

double degreesToRadians(double degrees) {
  return degrees * pi / 180;
}
