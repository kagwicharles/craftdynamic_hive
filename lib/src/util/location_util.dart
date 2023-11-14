import 'package:geolocator/geolocator.dart';

class LocationUtil {
  static getLatLong() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return {
      "lat": position.latitude.toString(),
      "long": position.longitude.toString()
    };
  }
}
