import '../constants/secrets.dart';
import './rest/dio_service.dart';
import '../models/google_api/place.dart';
import '../models/google_api/suggestion_place.dart';
import '../models/location.dart';

class GoogleMapsApi {
  final String sessionToken;
  final String apiKey = Secrets.apiKey;

  GoogleMapsApi(this.sessionToken);

  Future<List<SuggestionPlace>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&key=$apiKey&sessiontoken=$sessionToken';
    final response = await DioClient.dio.get(request);

    if (response.statusCode == 200) {
      final result = response.data;

      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<SuggestionPlace>((p) => SuggestionPlace(p['place_id'], p['description']))
            .toList();
      }

      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }

      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=name,geometry,formatted_address&key=$apiKey&sessiontoken=$sessionToken';
    final response = await DioClient.dio.get(request);

    if (response.statusCode == 200) {
      final result = response.data;

      if (result['status'] == 'OK') {
        final locate = result['result']['geometry']['location'] as Map<String, dynamic>;
        final address = result['result']['formatted_address'];
        final name = result['result']['name'];

        return Place(
          name: name,
          address: address,
          location: Location(lat: locate['lat'], lng: locate['lng']),
        );
      }

      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
