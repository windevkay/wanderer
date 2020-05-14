import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String googleApiKey = DotEnv().env['GOOGLE_API_KEY'];

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude}) {
    //gets a static map of a coordinate
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$googleApiKey';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    //uses a coordinate to get an address
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}